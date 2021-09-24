/*
 MIT License
 
 Copyright (c) 2017-2018 MessageKit
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

import UIKit
import MapKit
import MBProgressHUD
import AlamofireImage
//import MessageKit
//import MessageInputBar

final class BasicExampleViewController: ChatViewController {
    
   

    
    var alrController:UIAlertController?
    var choices:[Choice]?
    
    var suggestions:[Suggestion]?
    var circularProgress:ProgressBarView?
    
    let defaultPlaceholder = "Ask me something"
    let feedbackPlaceholder = "Want to share feedback?"
    var hud:MBProgressHUD?
    

  
   

  
    override func configureMessageCollectionView() {
        super.configureMessageCollectionView()
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
    }
    
    override func viewDidLoad() {
        messagesCollectionView = MessagesCollectionView(frame: .zero, collectionViewLayout: CustomMessagesFlowLayout())
        messagesCollectionView.keyboardDismissMode = .onDrag
        
        messagesCollectionView.register(QuickReplyButtonCollectionViewCell.self)
        messagesCollectionView.register(UINib(nibName: "QuickReplySSOCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "QuickReplySSOCollectionViewCell")
        messagesCollectionView.register(UINib(nibName: "CarouselCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CarouselCollectionViewCell")
        messagesCollectionView.register(UINib(nibName: "PropsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PropsCollectionViewCell")
        messagesCollectionView.register(UINib(nibName: "MultiOpsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MultiOpsCollectionViewCell")
        messagesCollectionView.register(UINib(nibName: "BottomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BottomCollectionViewCell")
        
            
        
         NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)
        
         NotificationCenter.default.addObserver(self, selector: #selector(self.carauselOptionButtonTapped(notification:)), name: Notification.Name("CarauselOptionButtonTapped"), object: nil)

        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardWillBeShown(note:)), name:UIResponder.keyboardWillShowNotification, object: nil)
        center.addObserver(self, selector: #selector(keyboardWillBeHidden(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        super.viewDidLoad()
       // updateTitleView(title: "MessageKit", subtitle: "2 Online")
        self.hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        self.callAPI()
        
        self.suggestionTable.isHidden = true
        self.suggestionTable.layer.cornerRadius = 10
        //self.suggestionTable.roundCorners(corners: [.topRight, .topLeft], radius: 10)
        self.view.bringSubviewToFront(suggestionTable)
        messageInputBar.inputTextView.delegate = self

        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.configureMessageInputBar()
     }
    
   override func setMessageInputBarOnMessageGet() {
    self.showReset()
       }
    
   override func showFeedbackInputTextBar()  {
    setCrossButton()
    showCross()
       }
    
    override func hideFeedbackInputTextBar()  {
     //  setCrossButton()
       hideCross()
          }
    
    
    
     func configureMessageInputBar() {
//        super.configureMessageInputBar()
        messageInputBar.delegate = self
     //   messageInputBar.heightAnchor.constraint(equalToConstant: 60).isActive = true
        messageInputBar.isTranslucent = true
        messageInputBar.separatorLine.isHidden = true
        messageInputBar.inputTextView.tintColor = .primaryColor
        messageInputBar.inputTextView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        messageInputBar.inputTextView.placeholderTextColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
        messageInputBar.inputTextView.textContainerInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 36)
        messageInputBar.inputTextView.placeholderLabelInsets = UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 36)
        messageInputBar.inputTextView.layer.borderColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1).cgColor
        messageInputBar.inputTextView.layer.borderWidth = 1.0
        messageInputBar.inputTextView.layer.cornerRadius = 16.0
        messageInputBar.inputTextView.layer.masksToBounds = true
        messageInputBar.inputTextView.isScrollEnabled = true
        messageInputBar.inputTextView.showsVerticalScrollIndicator = false
        messageInputBar.inputTextView.delegate = self
        messageInputBar.textViewPadding.right = 10
        messageInputBar.inputTextView.placeholder = defaultPlaceholder
        messageInputBar.inputTextView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        messageInputBar.inputTextView.scrollIndicatorInsets = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        configureInputBarItems()
    }
    
    private func configureInputBarItems() {
        setCircularProgress()
        setSendButton()
        setResetButton()
        manageResetButton()
        hideCross()
       
    }
    
    func setCircularProgress() {
        
      //  print(self.integration?.settings?.widget_textcolour)
        circularProgress =  ProgressBarView(frame: messageInputBar.sendButton.bounds)
        circularProgress!.trackClr = UIColor.lightGray
        circularProgress!.progressClr = self.integration?.settings?.widget_textcolour?.hexToUIColor ?? .green
        circularProgress!.isUserInteractionEnabled = false
        circularProgress!.backgroundColor = .clear
    }
    
    func setSendButton() {
        messageInputBar.setRightStackViewWidthConstant(to: 36, animated: false)
        messageInputBar.sendButton.imageView?.backgroundColor = UIColor.clear
               messageInputBar.sendButton.contentEdgeInsets = UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 0)
               messageInputBar.sendButton.setSize(CGSize(width: 36, height: 36), animated: false)
               messageInputBar.sendButton.setTintedImage = UIImage(named: "Send")
               messageInputBar.sendButton.title = nil
               messageInputBar.sendButton.isEnabled = true
               messageInputBar.sendButton.tintColor = UIColor.lightGray
               messageInputBar.sendButton.addSubview(circularProgress!)
             
               messageInputBar.sendButton
                   .onEnabled { item in
                       UIView.animate(withDuration: 0.3, animations: {
                       })
                   }.onDisabled { item in
                       UIView.animate(withDuration: 0.3, animations: {
                       })
               }.onTextViewDidChange { (item, textView) in
                       let value = Float(textView.text.count)
                   guard let maxCount = self.maxCharCount else{
                       return
                   }
                       let isOverLimit = textView.text.count > maxCount
                       if isOverLimit {
                           //item.messageInputBar?.sendButton.isEnabled = false
                       }
                       else{
                          // item.messageInputBar?.sendButton.isEnabled = true
                           self.circularProgress?.progress = (value)/Float(maxCount)
                           item.messageInputBar?.sendButton.tintColor = self.integration?.settings?.widget_textcolour?.hexToUIColor ?? .green

                   }
               }
    }
    
    func setResetButton() {
        messageInputBar.refreshButton.setSize(CGSize(width: 36, height: 36), animated: false)
        messageInputBar.refreshButton.setTintedImage = UIImage(named: "user3")
        messageInputBar.refreshButton.isEnabled = true
        messageInputBar.refreshButton.tintColor = self.integration?.settings?.widget_textcolour?.hexToUIColor ?? .green
              
               messageInputBar.refreshButton
                   .onTouchUpInside { (item) in
                    self.hideReset()
                    self.isResetTapped = true
               }
    }
    
   
    
    func manageResetButton()  {
      //  print(config?.reset_context)
        if (config?.reset_context ?? false){
                  showReset()
               }
               else{
             hideReset()
               }
    }
    
    func showReset() {
        messageInputBar.setLeftStackViewWidthConstant(to: 36, animated: false)
        // messageInputBar.setRightStackViewWidthConstant(to: 74, animated: false)
         messageInputBar.refreshButton.isHidden = false
        messageInputBar.crossButton.isHidden = true
        
    }
    
    func hideReset() {
          messageInputBar.setLeftStackViewWidthConstant(to: 0, animated: false)
         // messageInputBar.setRightStackViewWidthConstant(to: 36, animated: false)
          messageInputBar.refreshButton.isHidden = true
          messageInputBar.crossButton.isHidden = true

    
    }
    
    
    func setCrossButton() {
           messageInputBar.crossButton.setSize(CGSize(width: 36, height: 36), animated: false)
           messageInputBar.crossButton.isEnabled = true
           messageInputBar.crossButton.tintColor = UIColor.init(hexString: self.integration?.settings?.widget_textcolour ?? "#808080")
                 
                  messageInputBar.crossButton
                      .onTouchUpInside { (item) in
                       self.hideCross()
                  }
       }
                 
          func showCross() {
               messageInputBar.inputTextView.placeholder = feedbackPlaceholder
               messageInputBar.setLeftStackViewWidthConstant(to: 36, animated: false)
               messageInputBar.crossButton.isHidden = false
               messageInputBar.refreshButton.isHidden = true
               isFeedback = true

          }
          
          func hideCross() {
                messageInputBar.inputTextView.placeholder = defaultPlaceholder
               // messageInputBar.setRightStackViewWidthConstant(to: 36, animated: false)
           // messageInputBar.setLeftStackViewWidthConstant(to: 0, animated: false)
                messageInputBar.crossButton.isHidden = true
                manageResetButton()
                isFeedback = false

          
          }
       
    
    private func makeButton(named: String) -> InputBarButtonItem {
        return InputBarButtonItem()
            .configure {
                $0.spacing = .fixed(10)
                $0.image = UIImage(named: named)?.withRenderingMode(.alwaysTemplate)
                $0.setSize(CGSize(width: 25, height: 25), animated: false)
                $0.tintColor = UIColor(white: 0.8, alpha: 1)
            }.onSelected {
                $0.tintColor = .primaryColor
            }.onDeselected {
                $0.tintColor = UIColor(white: 0.8, alpha: 1)
            }.onTouchUpInside { _ in
              //  print("Item Tapped")
        }
    }
    
    
    @objc func carauselOptionButtonTapped(notification: Notification) {
        let option =  notification.object as! Option
        self.sendDataToServer(data: option.data)
        let message = MockMessage(text: option.data, sender: currentSender(), messageId: UUID().uuidString, date: Date())
               insertMessage(message)
               messagesCollectionView.scrollToBottom(animated: true)
          }
    
    
    @objc func methodOfReceivedNotification(notification: Notification) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ImageViewController") as! ImageViewController
        vc.image = notification.object as? UIImage
        self.present(vc, animated: true, completion: nil)
           print("Value of notification : ", notification.object ?? "")
       }
    
    func addNavTitleImage()  {
        let navHeight = self.navigationController!.navigationBar.frame.size.height - 30
        let navWidth = self.navigationController!.navigationBar.frame.size.width - 50
         navTitleImgView = UIImageView(frame: CGRect(x: 0, y: 0, width: navWidth, height: navHeight))
        navTitleImgView?.contentMode = .scaleAspectFit
        if self.config?.header_logo?.isEmpty ?? true{
            navTitleImgView?.image = self.NavTitleImg}else{
            navTitleImgView?.af_setImage(withURL: URL(string: self.config?.header_logo ?? "")!)
        }
        navigationItem.titleView = navTitleImgView
    }
    
    func getResponderImage()->UIImage {
        return self.responderImg
    }
    
    func getSenderImage()-> UIImage {
        return UIImage(named: "user1")!
    }
    
    
    func callAPI() {
         APIManager.sharedInstance.getConfiguration(url: "", successBlock: { (data) in
                  //    print(data)
            if let configData = data{
                self.config = configData.result
                self.integration = configData.result?.integration![0]
                self.maxCharCount = 100//self.integration?.read_more_limit?.character_count
                //self.isSSO = self.config?.sso ?? false ? 1:0
                self.getConfigImage()
                DispatchQueue.main.async { // Correct
                    self.configureMessageInputBar()
                    self.addNavTitleImage()
                    self.messagesCollectionView.backgroundColor = .clear
                    self.view.backgroundColor =
                        self.config?.theme_colour?.hexToUIColor
                    self.hud?.hide(animated: true)
                }
            }
                  }) { (error) in
                    DispatchQueue.main.async {
                        self.hud?.hide(animated: true)
                        print("error Configuration ======= \(error)")
                    }
                      
                  }
    }
    
    func getConfigImage()  {
        ImageDownloadManager().loadImage(imageURL: (self.config?.avatar)!) {[weak self] (taskURL, downloadedImage) in
                        if let img = downloadedImage {
                            DispatchQueue.main.async {
                                self!.responderImg = img
                            }
                        }
                        else{
                            self!.responderImg = UIImage(named: "user1")!
            }
        }
    }
    
    @objc func callSuggestionsAPI(txt:String) {
        
        APIManager.sharedInstance.getSuggestion(text: txt, contextId: self.messageData?.context_id ?? 0, successBlock: { (data) in
                   //   print(data)

                if let configData = data{
                    self.suggestions = configData
                    DispatchQueue.main.async { // Correct
                    self.suggestionTable.reloadData()
                    self.suggestionTable.isHidden = false
                }
            }
            }) { (error) in
                      print(error)

                    DispatchQueue.main.async {
                        self.suggestionTable.isHidden = true
                    }
                }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

//        if !self.logInPresented {
//            self.logInPresented = true
//            self.performSegue(withIdentifier: "LogInViewController", sender: nil)
//        }

    }
    
    override func loadFirstMessages() {
        self.messagesCollectionView.reloadData()
        self.messagesCollectionView.scrollToBottom()
    }
    
    override func loadMoreMessages() {
        self.messagesCollectionView.reloadDataAndKeepOffset()
        self.refreshControl.endRefreshing()
    }
    
    // MARK: - Custom feedback
   
    @IBAction func crossAction(_ sender: Any) {
        if config?.nps_settings?.custom_theme ?? false{
            self.moveToCustomeFeedback()
        }else{
            self.moveToNormalFeedback()
        }
    }
    
    func moveToCustomeFeedback()  {
          let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let feedbackSurveyVC = storyBoard.instantiateViewController(withIdentifier: "FeedbackSurveyVC") as! FeedbackSurveyVC
        feedbackSurveyVC.npsSettings = self.config?.nps_settings
        feedbackSurveyVC.NavTitleImg = self.navTitleImgView!.image!
                self.navigationController?.pushViewController(feedbackSurveyVC, animated: false)
    }
    
    func moveToNormalFeedback()  {
          let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let normalFeedbackVC = storyBoard.instantiateViewController(withIdentifier: "NormalFeedbackVC") as! NormalFeedbackVC
        normalFeedbackVC.NavTitleImg = self.navTitleImgView!.image!

                self.navigationController?.pushViewController(normalFeedbackVC, animated: false)
    }
    
    
    
    // MARK: - UICollectionViewDataSource
    
    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    guard let messagesDataSource = messagesCollectionView.messagesDataSource else {
    fatalError("Ouch. nil data source for messages")
    }
    let message = messagesDataSource.messageForItem(at: indexPath, in: messagesCollectionView)

    if case .quickReplyButton = message.kind {
    let cell = messagesCollectionView.dequeueReusableCell(QuickReplyButtonCollectionViewCell.self, for: indexPath)
    self.quickReplyIndexPath.append(indexPath)
        print("self.quickReplyIndexPath.count ========   \(self.quickReplyIndexPath.count)")
    cell.delegate = self
    cell.configure(with: self.messageList, at: indexPath, and: messagesCollectionView, with: (self.integration?.settings)!)
    return cell
    }
        
    else if case .quickReplySSO = message.kind {
    let cell = messagesCollectionView.dequeueReusableCell(QuickReplySSOCollectionViewCell.self, for: indexPath)
    cell.delegate = self
    cell.configure(with: self.messageList, at: indexPath, and: messagesCollectionView, with: (self.config)!)
    return cell
    }
        
    else if case .carousel = message.kind {
    let cell = messagesCollectionView.dequeueReusableCell(CarouselCollectionViewCell.self, for: indexPath)
    cell.configure(with: self.messageList, at: indexPath, and: messagesCollectionView, with: (self.integration?.settings)!)
    return cell
    }
        
    else if case .prop = message.kind {
    let cell = messagesCollectionView.dequeueReusableCell(PropsCollectionViewCell.self, for: indexPath)
    cell.delegate = self
    cell.configure(with: self.messageList, at: indexPath, and: messagesCollectionView, with: (self.integration?.settings)!)
    return cell
    }

    else if case .multiOps = message.kind {
    let cell = messagesCollectionView.dequeueReusableCell(MultiOpsCollectionViewCell.self, for: indexPath)
    cell.delegate = self
    cell.configure(with: self.messageList, at: indexPath, and: messagesCollectionView, with: (self.integration?.settings)!)
    return cell
    }

    else if case .bottom = message.kind {
    let cell = messagesCollectionView.dequeueReusableCell(BottomCollectionViewCell.self, for: indexPath)
    cell.configCell(isFeedback: self.messageData?.feedback?["text_feedback"] ?? false)
    cell.delegate = self
    return cell
    }

    return super.collectionView(collectionView, cellForItemAt: indexPath)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
    
        @IBAction func menuBtnClicked(_ sender: Any) {
            if let button = sender as? UIBarButtonItem {
                let popoverContentController = self.storyboard!.instantiateViewController(withIdentifier: "SettingPopoverViewController") as! SettingPopoverViewController
                popoverContentController.modalPresentationStyle = .popover
                popoverContentController.preferredContentSize = CGSize(width: 230, height: 81)
                popoverContentController.delegate = self
                
                if let popoverPresentationController = popoverContentController.popoverPresentationController {
                       popoverPresentationController.permittedArrowDirections = .up
                       popoverPresentationController.backgroundColor = UIColor.black.withAlphaComponent(0.65)
                       popoverPresentationController.sourceView = self.view
                       popoverPresentationController.barButtonItem = button
                       popoverPresentationController.delegate = self
                       
                       present(popoverContentController, animated: true, completion: nil)
                   }
            }
        }
    }


    extension BasicExampleViewController: SettingPopoverVCDelegate, UIPopoverPresentationControllerDelegate {
        
        func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
            return .none
        }
        
        //UIPopoverPresentationControllerDelegate
        func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        }
        
        func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
            return true
        }
        
        func didSelectectOption(index:Int){
            if index == 0{
                let settingViewController = self.storyboard!.instantiateViewController(withIdentifier: "SettingViewControllerViewController") as! SettingViewControllerViewController
                settingViewController.NavTitleImg = self.navTitleImgView!.image!
                settingViewController.languageArray = config?.language ?? [Language]()
                self.navigationController?.pushViewController(settingViewController, animated: true)
            }else{
                
            }
        }
    }

extension BasicExampleViewController: QuickReplyButtonCollectionViewCellDelegate, PropsCollectionViewCellDelegate, MultiOpsCollectionViewCellDelegate, BottomCollectionViewCellDelegate, QuickReplySSOCollectionViewCellDelegate,SSOWebVCViewControllerDelegate {
    func didTappedQuickReplyButton(type:String, text:String){
        self.isTypedMsg = false
        var deleteSections = [Int]()
        print(deleteSections.count)
      //  self.sendDataToServer(data: text)
       // let message = MockMessage(text: text, sender: currentSender(), messageId: UUID().uuidString, date: Date())
        
        print(self.messageList.count)
        
        self.messageList.removeAll(where: { message in
               switch message.kind {
                 case .quickReplyButton:
                    return true
                 default:
                     break
                 }
            return false
    })
    //    insertMessage(message)
        for i in 0..<self.messageList.count {
            let message = self.messageList[i]
            switch message.kind {
            case .quickReplyButton:
                deleteSections.append(i)
            default:
                break
            }
        }
        
        print(deleteSections.count)
        messagesCollectionView.deleteSections(IndexSet(deleteSections))

       //  print(self.messageList.count)
    }
    func didTappedQuickReplySSOButton(ssoUrl: String) {
        print("SSSO Tappped")
        self.isTypedMsg = false
        let popOverAlertVC = self.storyboard!.instantiateViewController(withIdentifier: "SSOWebVCViewController") as! SSOWebVCViewController
        
        popOverAlertVC.delegate = self
        popOverAlertVC.ssoURLStr = ssoUrl
        self.navigationController?.navigationBar.isHidden = true
        messageInputBar.isHidden = true
        self.addChild(popOverAlertVC)
        popOverAlertVC.view.frame = self.view.frame
        self.view.addSubview(popOverAlertVC.view)
        popOverAlertVC.didMove(toParent: self)
    }
    
    func ssoLoggedInSuccessfullyWith(sessionId:String){
        print(sessionId)
        self.isSSO = 1
        self.ssoSessionId = sessionId
        self.navigationController?.navigationBar.isHidden = false
        messageInputBar.isHidden = false
        
        self.sendDataToServer(data: "")
        
        
    }
    
    func didTappedPropsButton(urlStr:String)
    {
//        let urlString = "example.com"
//        let validUrlString = dataText.hasPrefix("http") ? urlString : "http://\(urlString)"
        self.isTypedMsg = false
        let validUrlString = (urlStr.hasPrefix("http") || urlStr.hasPrefix("https")) ? urlStr : "https://\(urlStr)"
        
        if let url = URL(string: validUrlString){
        if #available(iOS 10.0, *) {
                   UIApplication.shared.open(url, options: [:], completionHandler: nil)
               } else {
                   UIApplication.shared.openURL(url)
               }
               print("URL Selected: \(url)")
    }
    }
    
     
    func didTappedMoreOptionButton(choices:[Choice]){
        self.isTypedMsg = false
        self.choices = choices
        self.openPopup()
        
    }
    func didTappedChoice(value:String){
        self.isTypedMsg = false
        self.sendDataToServer(data: value)
              let message = MockMessage(text: value, sender: currentSender(), messageId: UUID().uuidString, date: Date())
              insertMessage(message)
              messagesCollectionView.scrollToBottom(animated: true)
    }
    
    func didTappedThumbButton(thumbType: String) {
        self.isTypedMsg = false
        isThumbFeedback = true
        isFeedback = false
        
        if thumbType == "up"{
            isThumbsUp = true
        }
        else{
            isThumbsUp = false
        }
        
         self.sendDataToServer(data: "")
    }
}

// MARK: - POPOverTableViewDelegateDelegate
extension BasicExampleViewController: UITableViewDataSource, UITableViewDelegate {
    
   func openPopup() {

            alrController = UIAlertController(title: "Title\n\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: UIAlertController.Style.alert)
            let margin:CGFloat = 8.0
    let rect = CGRect(x: 5, y: 50, width: 262, height: 200)
            var tableView = UITableView(frame: rect)
            tableView.delegate = self
            tableView.dataSource = self
            tableView.backgroundColor = UIColor.clear
            tableView.showsVerticalScrollIndicator = false
            alrController?.view.addSubview(tableView)

//            let somethingAction = UIAlertAction(title: "Something", style: UIAlertAction.Style.default, handler: {(alert: UIAlertAction!) in //println("something")
//
//            })

            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: {(alert: UIAlertAction!) in //println("cancel")
                    
                })

            alrController!.addAction(cancelAction)

            self.present(alrController!, animated: true, completion:{})
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if(tableView ==  suggestionTable)
            {
                return self.suggestions?.count ?? 0
            }
            
            return self.choices?.count ?? 0
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            
            return UITableView.automaticDimension
        }
        
        func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
            
            let view = UIView()
            view.backgroundColor = .clear
            return view
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            if(tableView ==  suggestionTable)
            {
                var text = self.suggestions![indexPath.row].originalText
                self.sendDataToServer(data: text!)
                let message = MockMessage(text: text!, sender: currentSender(), messageId: UUID().uuidString, date: Date())
                                 insertMessage(message)
                                 messagesCollectionView.scrollToBottom(animated: true)
                self.suggestionTable.isHidden = true
                messageInputBar.inputTextView.text = ""
                self.isTypedMsg = true

                return
            }
            let text = self.choices![indexPath.row].value
            let message = MockMessage(text: text, sender: currentSender(), messageId: UUID().uuidString, date: Date())
            insertMessage(message)
            alrController?.dismiss(animated: true, completion: nil)
            messagesCollectionView.scrollToBottom(animated: true)
            self.sendDataToServer(data: text)
                 
            
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            if(tableView ==  suggestionTable)
            {
                var cell : UITableViewCell!
                cell = tableView.dequeueReusableCell(withIdentifier: "suggestionCell")
                if cell == nil {
                    cell = UITableViewCell(style: .default, reuseIdentifier: "suggestionCell")
                }
                cell.textLabel?.text = self.suggestions![indexPath.row].originalText
                cell.backgroundColor = .clear
                return cell
            }
            
            var cell : UITableViewCell!
            cell = tableView.dequeueReusableCell(withIdentifier: "popupcell")
            if cell == nil {
                cell = UITableViewCell(style: .default, reuseIdentifier: "popupcell")
            }
            
            cell.textLabel?.text = self.choices![indexPath.row].label
            cell.backgroundColor = .clear

            return cell
        }
        
        
        
    

}

// MARK: - MessagesDisplayDelegate

extension BasicExampleViewController: MessagesDisplayDelegate {
    
    // MARK: - Text Messages
    
    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? (integration?.settings?.sender_text_icon?.hexToUIColor ?? UIColor.blue) : (integration?.settings?.response_text_icon?.hexToUIColor) ?? UIColor.gray
    }
    
    
    func detectorAttributes(for detector: DetectorType, and message: MessageType, at indexPath: IndexPath) -> [NSAttributedString.Key: Any] {
        return MessageLabel.defaultAttributes
    }
    
    func enabledDetectors(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> [DetectorType] {
        return [.url, .address, .phoneNumber, .date, .transitInformation]
    }
    
    
    
    
    
    // MARK: - All Messages
    
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? (integration?.settings?.sender_bubble?.hexToUIColor ?? UIColor.blue) : (integration?.settings?.response_bubble?.hexToUIColor) ?? UIColor.gray
    }
    
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        
        let tail: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .topRight : .topLeft
        //aj007
        return .bubbleTail(tail, .curved)
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        let senderAvatar = Avatar(image: getSenderImage(), initials: "")
        let responderAvatar = Avatar(image: getResponderImage(), initials: "")
        isFromCurrentSender(message: message) ?  avatarView.set(avatar: senderAvatar):avatarView.set(avatar: responderAvatar)
    }
    
    
    
    
    
    
    
    
    // MARK: - Location Messages
    
    func annotationViewForLocation(message: MessageType, at indexPath: IndexPath, in messageCollectionView: MessagesCollectionView) -> MKAnnotationView? {
        let annotationView = MKAnnotationView(annotation: nil, reuseIdentifier: nil)
        let pinImage = #imageLiteral(resourceName: "user3")
        annotationView.image = pinImage
        annotationView.centerOffset = CGPoint(x: 0, y: -pinImage.size.height / 2)
        return annotationView
    }
    
    func animationBlockForLocation(message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> ((UIImageView) -> Void)? {
        return { view in
            view.layer.transform = CATransform3DMakeScale(2, 2, 2)
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: [], animations: {
                view.layer.transform = CATransform3DIdentity
            }, completion: nil)
        }
    }
    
    func snapshotOptionsForLocation(message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> LocationMessageSnapshotOptions {
        return LocationMessageSnapshotOptions(showsBuildings: true, showsPointsOfInterest: true, span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
    }
    
}




// MARK: - MessagesLayoutDelegate

extension BasicExampleViewController: MessagesLayoutDelegate {
    
    func cellTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 0
    }
    
    func messageTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 0
    }
    
    func messageBottomLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 0
    }
    
}


// MARK: - InputTextViewDelegate
extension BasicExampleViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        if !isFeedback{
        if(textView.text.count > 3)
        {
            NSObject.cancelPreviousPerformRequests(withTarget: self,
                                                   selector: #selector(self.callSuggestionsAPI(txt:)),
                                                   object: nil)

            perform(#selector(self.callSuggestionsAPI(txt:)),
                    with: textView.text, afterDelay: 0.1)
        } else
        {
            self.suggestionTable.isHidden = true
        }
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool{
        let maxLength =  self.maxCharCount ?? 10
        let currentString: NSString = textView.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: text) as NSString
      //  print("\(newString) === \(newString.length)")
        return newString.length <= maxLength
       // return false
    }
    
}


// MARK: - Keyboard Notifications
extension BasicExampleViewController {
    
    @objc func keyboardWillBeShown(note: Notification) {
        let userInfo = note.userInfo
        let keyboardFrame = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        print("keyboardFrame.height ==== \(keyboardFrame.height)")
        suggestionBottomConstraint.constant = keyboardFrame.height > 370 ? (keyboardFrame.height - 40):keyboardFrame.height
    }
    
    @objc func keyboardWillBeHidden(note: Notification) {
        suggestionBottomConstraint.constant = 0
    }
}



