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
//import MessageKit
//import MessageInputBar
import XMPPFramework
import AVKit
import MBProgressHUD


/// A base class for the example controllers
class ChatViewController: MessagesViewController, MessagesDataSource {
    @IBOutlet weak var suggestionBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var suggestionTable: UITableView!
    
    var isDisplayed = false
    var buttonsIndexPath : IndexPath?
    var userId:String?
    weak var logInViewController: LogInViewController?
    var logInPresented = false
    var xmppController: XMPPController!
    let xmppRosterStorage = XMPPRosterCoreDataStorage()
    var xmppRoster: XMPPRoster!
    var messageData:MessageData?
    var isResetTapped:Bool = false
    var maxCharCount:Int?
    var integration:Integration?
    var config:Config?
    var isFeedback:Bool = false
    var isSSO:Int? = 0
    var ssoSessionId:String?
    var isThumbFeedback:Bool = false
    var isThumbsUp:Bool = true
   // var senderImg:UIImage = UIImage(named: "user1")!
    var responderImg:UIImage = UIImage(named: "user1")!
    var NavTitleImg:UIImage = UIImage(named: "user1")!
    var navTitleImgView:UIImageView?
    var quickReplyIndexPath:[IndexPath] = []
    var isTypedMsg = true





    
    let clientToken = "eyJ2ZXJzaW9uIjoyLCJhdXRob3JpemF0aW9uRmluZ2VycHJpbnQiOiI4NmMyOGMyYTYzOWQ1MmFhZTUxOGExNjU2ZDA5MDlhYTRkOTdjMmJjMjc1MGExMDlkYmZhNTRlNWRlZjc5MjcwfGNyZWF0ZWRfYXQ9MjAxOC0wMS0yMlQxMDo0OTo1Ny4zMzMyNTQ3NTArMDAwMFx1MDAyNm1lcmNoYW50X2lkPTM0OHBrOWNnZjNiZ3l3MmJcdTAwMjZwdWJsaWNfa2V5PTJuMjQ3ZHY4OWJxOXZtcHIiLCJjb25maWdVcmwiOiJodHRwczovL2FwaS5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tOjQ0My9tZXJjaGFudHMvMzQ4cGs5Y2dmM2JneXcyYi9jbGllbnRfYXBpL3YxL2NvbmZpZ3VyYXRpb24iLCJjaGFsbGVuZ2VzIjpbXSwiZW52aXJvbm1lbnQiOiJzYW5kYm94IiwiY2xpZW50QXBpVXJsIjoiaHR0cHM6Ly9hcGkuc2FuZGJveC5icmFpbnRyZWVnYXRld2F5LmNvbTo0NDMvbWVyY2hhbnRzLzM0OHBrOWNnZjNiZ3l3MmIvY2xpZW50X2FwaSIsImFzc2V0c1VybCI6Imh0dHBzOi8vYXNzZXRzLmJyYWludHJlZWdhdGV3YXkuY29tIiwiYXV0aFVybCI6Imh0dHBzOi8vYXV0aC52ZW5tby5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tIiwiYW5hbHl0aWNzIjp7InVybCI6Imh0dHBzOi8vY2xpZW50LWFuYWx5dGljcy5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tLzM0OHBrOWNnZjNiZ3l3MmIifSwidGhyZWVEU2VjdXJlRW5hYmxlZCI6dHJ1ZSwicGF5cGFsRW5hYmxlZCI6dHJ1ZSwicGF5cGFsIjp7ImRpc3BsYXlOYW1lIjoiQWNtZSBXaWRnZXRzLCBMdGQuIChTYW5kYm94KSIsImNsaWVudElkIjpudWxsLCJwcml2YWN5VXJsIjoiaHR0cDovL2V4YW1wbGUuY29tL3BwIiwidXNlckFncmVlbWVudFVybCI6Imh0dHA6Ly9leGFtcGxlLmNvbS90b3MiLCJiYXNlVXJsIjoiaHR0cHM6Ly9hc3NldHMuYnJhaW50cmVlZ2F0ZXdheS5jb20iLCJhc3NldHNVcmwiOiJodHRwczovL2NoZWNrb3V0LnBheXBhbC5jb20iLCJkaXJlY3RCYXNlVXJsIjpudWxsLCJhbGxvd0h0dHAiOnRydWUsImVudmlyb25tZW50Tm9OZXR3b3JrIjp0cnVlLCJlbnZpcm9ubWVudCI6Im9mZmxpbmUiLCJ1bnZldHRlZE1lcmNoYW50IjpmYWxzZSwiYnJhaW50cmVlQ2xpZW50SWQiOiJtYXN0ZXJjbGllbnQzIiwiYmlsbGluZ0FncmVlbWVudHNFbmFibGVkIjp0cnVlLCJtZXJjaGFudEFjY291bnRJZCI6ImFjbWV3aWRnZXRzbHRkc2FuZGJveCIsImN1cnJlbmN5SXNvQ29kZSI6IlVTRCJ9LCJtZXJjaGFudElkIjoiMzQ4cGs5Y2dmM2JneXcyYiIsInZlbm1vIjoib2ZmIn0="
    
    
    var contentStruct : ContentStruct?
    //007
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var messageList: [MockMessage] = []
    
    let refreshControl = UIRefreshControl()
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMessageCollectionView()
        self.connectXMPPwith(userJID: "", userPassword: "", server: "")
    }
 
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
     //   configureMessageInputBar()
//        if !self.logInPresented {
//            self.logInPresented = true
//            self.performSegue(withIdentifier: "LogInViewController", sender: nil)
//        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "LogInViewController" {
//            let viewController = segue.destination as! LogInViewController
//            viewController.delegate = self as? LogInViewControllerDelegate
//        }
    }
 
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        MockSocket.shared.disconnect()
    }
    
    func loadFirstMessages() {
                    self.messagesCollectionView.reloadData()
                    self.messagesCollectionView.scrollToBottom()
    }
    
    @objc
    func loadMoreMessages() {
                    self.messagesCollectionView.reloadDataAndKeepOffset()
                    self.refreshControl.endRefreshing()
    }
    
    func configureMessageCollectionView() {
       

        //messagesCollectionView.topAnchor.
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messageCellDelegate = self
        scrollsToBottomOnKeyboardBeginsEditing = true // default false
        maintainPositionOnKeyboardFrameChanged = true // default false
        
        messagesCollectionView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(loadMoreMessages), for: .valueChanged)
    }

    
    func setMessageInputBarOnMessageGet() {
       }
    
    func showFeedbackInputTextBar()  {
    }
    func hideFeedbackInputTextBar(){
    }
    
    // MARK: - Helpers
    
    func insertMessage(_ message: MockMessage) {
        messageList.append(message)
        // Reload last section to update header/footer labels and insert a new one
        messagesCollectionView.performBatchUpdates({
            messagesCollectionView.insertSections([messageList.count - 1])
            if messageList.count >= 2 {
                messagesCollectionView.reloadSections([messageList.count - 2])
            }
        }, completion: { [weak self] _ in
            if self?.isLastSectionVisible() == true {
                self?.messagesCollectionView.scrollToBottom(animated: true)
            }
        })
    }
    
    func isLastSectionVisible() -> Bool {
        guard !messageList.isEmpty else { return false }
        let lastIndexPath = IndexPath(item: 0, section: messageList.count - 1)
        return messagesCollectionView.indexPathsForVisibleItems.contains(lastIndexPath)
    }
    
    
    // MARK: - UICollectionViewDataSource
    
//    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        guard let messagesDataSource = messagesCollectionView.messagesDataSource else {
//            fatalError("Ouch. nil data source for messages")
//        }
//
//        //        guard !isSectionReservedForTypingBubble(indexPath.section) else {
//        //            return super.collectionView(collectionView, cellForItemAt: indexPath)
//        //        }
//
//        let message = messagesDataSource.messageForItem(at: indexPath, in: messagesCollectionView)
//        if case .custom = message.kind {
//            let cell = messagesCollectionView.dequeueReusableCell(QuickReplyButtonCollectionViewCell.self, for: indexPath)
//            cell.configure(with: message, at: indexPath, and: messagesCollectionView)
//            return cell
//        }
//        return super.collectionView(collectionView, cellForItemAt: indexPath)
//    }
    
    
    
    // MARK: - MessagesDataSource
    func currentSender() -> Sender {
        return SampleData.shared.currentSender
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messageList.count
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
       // print("messageList.count ==== \(messageList.count)")

        return messageList[indexPath.section]
    }
    
    func cellTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        if indexPath.section % 3 == 0 {
            return NSAttributedString(string: MessageKitDateFormatter.shared.string(from: message.sentDate), attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 10), NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        }
        return nil
    }
    
    func messageTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let name = message.sender.displayName
        return NSAttributedString(string: name, attributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .caption1)])
    }
    
    func messageBottomLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        
        let dateString = formatter.string(from: message.sentDate)
        return NSAttributedString(string: dateString, attributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .caption2)])
    }
}



// MARK: - LogInViewControllerDelegate
//AJEET
extension ChatViewController: LogInViewControllerDelegate {
    
    func didTouchLogIn(sender: LogInViewController, userJID: String, userPassword: String, server: String) {
        self.logInViewController = sender
        
        
    }
    
    
    func connectXMPPwith(userJID: String, userPassword: String, server: String)  {
        do {
            try self.xmppController = XMPPController(hostName: Assistent.hostUrl,
                                                     userJIDString: "\(Assistent.userName)@\(Assistent.vHost)",
                                                     password: Assistent.password)
            self.xmppController.xmppStream.addDelegate(self, delegateQueue: DispatchQueue.main)
            self.xmppController.connect()
        }
        catch {
            self.showAlert(message: "Something went wrong", title: "Oops!")
        }
    }
}



// MARK: - ChatViewController Extension to send Data to XMPP Server

extension ChatViewController{

func sendIQ() {
    let iq = DDXMLElement.element(withName: "iq") as! DDXMLElement
    iq.addAttribute(withName: "id", stringValue: "asas213123")//UID...
    iq.addAttribute(withName: "type", stringValue: "get")
    iq.addAttribute(withName: "to", stringValue: Assistent.vHost)//VHOST....
    iq.addAttribute(withName: "xmlns", stringValue: "jabber:client")
    
    let query = DDXMLElement.element(withName: "query") as! DDXMLElement
    query.addAttribute(withName: "xmlns", stringValue: "xavbot:simulate:create:room")
    
    iq.addChild(query)
    xmppController.xmppStream.send(iq)
    
}



func sendDataToServer(data : String){
    var inputStr = data
    if self.messageData?.encrypted == 1{
        inputStr = self.getEcryptedText(inputText: inputStr)
    }
// 
    var arrayOfDictionaries = ["log":"true",
                               "form_type":"click",
                               "timezoneOffset":"-339",
                               "msg":inputStr,
                               "bot_id":"\(Assistent.botId)",
                               "bot_name":"Mobility Dev Bot-Do not delete or rename",
                               "language_id":"\(Assistent.language)",
                               "template_id":0,
                               "context_life_span":self.messageData?.context_life_span ?? 0,
                               "contexts":self.messageData?.contexts ?? [],
                               "user_session_id":self.messageData?.user_session_id,
                               "context_id":self.messageData?.context_id,
                               "sentiment":self.messageData?.sentiment ?? 0,
                               "nlu_service":"s0"] as [String : Any]
    
    if self.messageData?.is_prompt == 1{
        arrayOfDictionaries["intent"] = self.messageData?.intent
        arrayOfDictionaries["intent_name"] = self.messageData?.intent_name
        arrayOfDictionaries["reply_index"] = self.messageData?.reply_index
        arrayOfDictionaries["user_prompt"] = self.messageData?.user_prompt
        arrayOfDictionaries["query"] = self.messageData?.query
        arrayOfDictionaries["is_prompt"] = self.isTypedMsg ? self.messageData?.is_prompt:0
    }
    
    arrayOfDictionaries["is_typed"] = self.isTypedMsg ? 1:0

    
    if self.messageData?.masked == 1{
        
    }
    
    
    
    
//    self.messageData?.classified = 1
//    arrayOfDictionaries["classified"] = true
    
    if self.messageData?.classified == 1{
        arrayOfDictionaries["classified"] = true
    }
    
   if self.isSSO == 1{
        let meta = ["sso_response":true]
        arrayOfDictionaries["msg_session"] = self.ssoSessionId
        arrayOfDictionaries["authorized"] = true
        arrayOfDictionaries["require_sso"] = true
        arrayOfDictionaries["meta_data"] = meta
        arrayOfDictionaries["is_prompt"] = false
    }
  
    if self.isResetTapped{
        arrayOfDictionaries["contexts"] = []
        arrayOfDictionaries["clear_context"] = true
        self.isResetTapped = false
        
    }
    
    if isFeedback{
        arrayOfDictionaries["is_text_feedback"] = true
        if let msgId = self.messageData?.user_message_id{
            arrayOfDictionaries["msg_id"] = msgId
        }
        else{
            arrayOfDictionaries["msg_id"] = 1
        }
        self.hideFeedbackInputTextBar()
       // isFeedback = false
    }
    
    if isThumbFeedback{
        arrayOfDictionaries["thumbsup"] = isThumbsUp
        if let msgId = self.messageData?.user_message_id{
            arrayOfDictionaries["msg_id"] = msgId
        }
        else{
            arrayOfDictionaries["msg_id"] = 1
        }
        isThumbFeedback = false
        self.hideFeedbackInputTextBar()
    }
    
    print(arrayOfDictionaries)
    self.createRequestForServer(arrayOfDictionaries: arrayOfDictionaries, data: data)
}


    func createRequestForServer(arrayOfDictionaries:[String : Any], data:String) {
        var error : NSError?
        let jsonData = try! JSONSerialization.data(withJSONObject: arrayOfDictionaries, options:[])
        let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
        let str = "![CDATA[" + jsonString + "]]"
        let body = DDXMLElement.element(withName: "body", stringValue: str) as! DDXMLElement
        let messageID = xmppController.xmppStream.generateUUID
        let completeMessage = DDXMLElement.element(withName: "message") as! DDXMLElement
        completeMessage.addAttribute(withName: "type", stringValue: "groupchat")
        completeMessage.addAttribute(withName: "to", stringValue: "bot_\(Assistent.userName)@conference.\(Assistent.vHost)")
                if self.messageData?.classified == 1{
                    completeMessage.addAttribute(withName: "otr", stringValue: "true")
                }
        
        ///"bot_"+username+"@conference."+VHOST
        completeMessage.addAttribute(withName: "from", stringValue: "\(Assistent.userName)@\(Assistent.vHost)")//username+"@"+VHOST
       // completeMessage.addAttribute(withName: "subject", stringValue: "App")
        completeMessage.addAttribute(withName: "xml:lang", stringValue: "\(Assistent.language)")
//        if self.messageData?.classified == 1{
//            completeMessage.addAttribute(withName: "otr", stringValue: "true")
//        }
        completeMessage.addChild(body)
        print(xmppController.xmppStream.isConnected)
        print(completeMessage)
        xmppController.xmppStream.send(completeMessage)
    }


func sendWelcomeToServer(data : String){
    print("SEND WELCOME MESSAGE")
    let arrayOfDictionaries = ["welcome_msg_check":"true","username": "Ajeet","email": "ajeet@gmail.com","phone":4545454,"log":"true","form_type":"click","timezoneOffset":"-339","msg":"GETAWELCOMEMESSAGE","bot_id":"\(Assistent.botId)" ,"bot_name":"\(Assistent.botName)","language_id":"\(Assistent.language)","template_id":0,"context_id":0, "nlu_service":"s0"] as [String : Any]
    self.createRequestForServer(arrayOfDictionaries: arrayOfDictionaries, data: data)

}
    
    
    func getEcryptedText(inputText:String) -> String{
       let sessionId = (UserDefaults.standard.value(forKey: "SessionId") as! String)
        let AES = CryptoJS.AES()
//        let iv = "1234567"
        // AES encryption
        let encrypted = AES.encrypt(inputText, password: self.messageData?.encryption_key ?? "")
        print("encrypted======\(encrypted)")
        let encryptedText = sessionId + encrypted
        print(encryptedText)
        return encryptedText
       
    }
    
    func callNumber(phoneNumber:String) {
        if let phoneCallURL = URL(string: "telprompt://\(phoneNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                if #available(iOS 10.0, *) {
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                } else {
                    application.openURL(phoneCallURL as URL)
                }
            }
        }
    }
}





// MARK: - XMPPStreamDelegate

extension ChatViewController: XMPPStreamDelegate{
    
    func xmppMessageArchiveManagement(_ xmppMessageArchiveManagement: XMPPMessageArchiveManagement, didReceiveMAMMessage message: XMPPMessage) {
        print(message.body)
    }
    
    func xmppStreamDidAuthenticate(_ sender: XMPPStream!) {
        self.sendIQ()
        self.logInViewController?.dismiss(animated: true, completion: nil)
    }
    
    func xmppStream(_ sender: XMPPStream!, didNotAuthenticate error: DDXMLElement!) {
        self.logInViewController?.showErrorMessage(message: "Wrong password or username")
    }

    func xmppStream(_ sender: XMPPStream, didReceive iq: XMPPIQ) -> Bool {
        var jId = "\(sender.myJID)"
        jId = jId.components(separatedBy: "/")[0]
        UserDefaults.standard.setValue(jId, forKey: "JiD")
        
        if iq.attributeStringValue(forName: "id") == "asas213123"{
            print("IQ RESPONSE ======\(iq.description)")
            //converting into NSData
            let data: Data? = iq.description.data(using: .utf8)

            //initiate  NSXMLParser with this data
            let parser: XMLParser? = XMLParser(data: data ?? Data())

            //setting delegate
            parser?.delegate = self

            //call the method to parse
            var _: Bool? = parser?.parse()

            parser?.shouldResolveExternalEntities = true
            
            self.sendWelcomeToServer(data: "")
        }
        return true
    }
    
    
    func xmppStream(_ sender: XMPPStream!, didReceive message: XMPPMessage!) {
        if let checkStr : String = message.body{
            print(checkStr)
            if(!checkStr.contains("![CDATA[")){
                return
            }
        }
        if( message?.body == nil){
            return
        }
        
        let removedCDATA = message.body?.replacingOccurrences(of: "![CDATA[", with: "")
        let removedBracket = removedCDATA?.dropLast().dropLast()
        let removedBackSlash = removedBracket?.replacingOccurrences(of: "", with: "")
        guard let messageData = removedBackSlash?.parseJosonResponse() else {
            return
        }
        self.messageData = messageData
        print("RESPONE LIST ========= \(self.messageData!.responseList)")
      var timer = 0.0
       // updateTitleView(title: "ChatBot", subtitle: "Typing...")
        if messageData.responseList.count > 0{
        for i in 0...messageData.responseList.count {
             timer = timer + 2
            DispatchQueue.main.asyncAfter(deadline: .now() + timer, execute: {
                if (self.config?.reset_context ?? false) {
                    self.setMessageInputBarOnMessageGet()
                }
                let textFeedback = self.messageData?.feedback?["text_feedback"]
                if (textFeedback ?? false) {
                    self.showFeedbackInputTextBar()
                }
                if i == messageData.responseList.count{
                    self.messageList.append(contentsOf: self.getMessage(response: nil, sender: message.from?.user! as! String, messageType: ""))
                }else{
                    let response:Response = messageData.responseList[i]
                                   print(response)
                                   self.messageList.append(contentsOf: self.getMessage(response: response, sender: message.from?.user! as! String, messageType: response.responseType))
                }
                 self.loadFirstMessages()
            })
        }
    }
    }
    
   
    //FIXME:- Uncomment below function and fix error
    /*func getThumbnailForVideo(url:String)-> UIImage{
        DispatchQueue.global().async {
            let asset = AVAsset(url: URL(string: url)!)
            let assetImgGenerate : AVAssetImageGenerator = AVAssetImageGenerator(asset: asset)
            assetImgGenerate.appliesPreferredTrackTransform = true
            let time = CMTimeMake(value: 1, timescale: 2)
            let img = try? assetImgGenerate.copyCGImage(at: time, actualTime: nil)
            if img != nil {
                let frameImg  = UIImage(cgImage: img!)
                DispatchQueue.main.async(execute: {
                    // assign your image to UIImageView
                    return frameImg
                })
            }
        }
        return UIImage(named: "Image")!
    }*/
    
    func getImage(urlStr:String)-> UIImage{

        return UIImage(named: "Image")!
    }
    
    
    func getMessage(response:Response?, sender:String , messageType:String) -> [MockMessage] {
        let uniqueID = NSUUID().uuidString
        let sender = Sender(id: sender, displayName: sender)
        let date = Date()
        let messageType = messageType
        var mockMsgArray:[MockMessage] = []

        switch messageType {
            
        case "text":
            var text = response?.stringArray?[0]
        //    let attributedString = NSAttributedString(string: text!)
         //  text = text?.withoutHtml
       // text = String(text!.dropLast())
//            text = "<p><u>This is a </u><strong><u>text </u></strong><em><u>card </u><s><u>strike</u></s></em></p><p><br></p><ol><li><em><s><u>a</u></s></em></li><li><em><s><u>b</u></s></em></li><li><em><s><u>c</u></s></em></li><li><em><s><u>d</u></s></em></li></ol><p><br></p><p class=\"ql-indent-2\">Paragragh</p><p class=\"ql-indent-1\"><br></p><p><a href=\"https://google.com\" rel=\"noopener noreferrer\" target=\"_blank\">Https://google.com</a></p><p><br></p><p>Query link <a class=\"queryLink\" href=\"javascript:void(0);\" data-query=\"query link keyword\" data-displayname=\"Keyword\">Keyword</a></p><p><br></p><p>Query link <a class=\"queryLink\" href=\"javascript:void(0);\" data-query=\"this is a check for ML\" data-displayname=\"ML\">ML</a></p><p><br></p><p>Query link</p><p><br></p><p><img src=\"https://cdn.jsdelivr.net/emojione/assets/3.0/png/32/1f600.png\"><img src=\"https://cdn.jsdelivr.net/emojione/assets/3.0/png/32/1f603.png\"><img src=\"https://cdn.jsdelivr.net/emojione/assets/3.0/png/32/1f604.png\"> <img src=\"https://cdn.jsdelivr.net/emojione/assets/3.0/png/32/1f600.png\"></p><p><img src=\"https://storage.googleapis.com/kbbot-qa-storage/blobs/191Lh4NqAVigSt9R4klxMLmo05Z/1ae2bf48-7a57-4a8b-8d02-413aa1153f00.jpg\"></p><p><br></p><iframe class=\"ql-video\" frameborder=\"0\" allowfullscreen=\"true\" src=\"https://upload.wikimedia.org/wikipedia/commons/2/2c/Kettenfont%C3%A4ne_Video.ogv\"></iframe><p><br></p>"
            
            let attText = try? NSAttributedString(htmlString: text!, font: UIFont(name: "HelveticaNeue", size: 16), useDocumentFontSize: false, useDocumentFontColor:true)
            
            
            print(attText)
            
            
            mockMsgArray.append(MockMessage(attributedText: attText!, sender: sender, messageId: uniqueID, date: date))
            
         //   mockMsgArray.append(MockMessage(text: text ?? "", sender: sender, messageId: uniqueID, date: date))
            return mockMsgArray
            
        case "AttributedText":
            var text = response?.stringArray?[0]
            text = text?.withoutHtml
             text = String(text!.dropLast())
            mockMsgArray.append(MockMessage(text: text ?? "", sender: sender, messageId: uniqueID, date: date))
            return mockMsgArray
            
        case "image":
            mockMsgArray.append(MockMessage(image:UIImage(named: "Image")!, urlStr: response?.stringArray?[0] ?? "",sender: sender, messageId: uniqueID, date: date))
            return mockMsgArray
            
        case "video":
            
            mockMsgArray.append(MockMessage(thumbnail:getImage(urlStr: response?.stringArray?[0] ?? ""),url: URL(string: (response?.stringArray?[0])!)! ,sender: sender, messageId: uniqueID, date: date))
            return mockMsgArray

        case "Emoji":
            var text = response?.stringArray?[0]
            text = text?.withoutHtml
            mockMsgArray.append(MockMessage(text: text ?? "", sender: sender, messageId: uniqueID, date: date))
            return mockMsgArray

        case "Location":
            var text = response?.stringArray?[0]
            text = text?.withoutHtml
            mockMsgArray.append(MockMessage(text: text ?? "", sender: sender, messageId: uniqueID, date: date))
            return mockMsgArray

        case "url":
            let url = response?.stringArray?[0]
            mockMsgArray.append(MockMessage(text: url!, sender: sender, messageId: uniqueID, date: date))
            return mockMsgArray
        case "Phone":
            mockMsgArray.append(MockMessage(text: "123-456-7890", sender: sender, messageId: uniqueID, date: date))
            return mockMsgArray
            
        case "quick_reply":
            print("MESSAGE TYPE QUICK REPLY")
            
            
            for qrBtton in response!.quickReplyArray{
                if qrBtton.type == "sso"{
                    mockMsgArray.append(MockMessage(qrSSOResponse: response!, sender: sender, messageId: uniqueID, date: date))
                }
                else{
                    mockMsgArray.append(MockMessage(quickReplyButton: qrBtton , sender: sender, messageId: uniqueID, date: date))}
            }
            
            return mockMsgArray
            
        case "carousel":
            print("MESSAGE TYPE QUICK REPLY")
            
            for carousel in response!.carousalArray{
                mockMsgArray.append(MockMessage(carousel: carousel, sender: sender, messageId: uniqueID, date: date))
            }
            
            return mockMsgArray
            
        case "props":
            print("MESSAGE TYPE Props REPLY")
            let prop = response?.prop
                mockMsgArray.append(MockMessage(prop: prop!, sender: sender, messageId: uniqueID, date: date))
            
            return mockMsgArray
            
        case "multi_ops":
            print("MESSAGE TYPE Props REPLY")
            let multiOps = response?.multiOps
            mockMsgArray.append(MockMessage(multiOptional: multiOps!, sender: sender, messageId: uniqueID, date: date))
                       
            return mockMsgArray
                                    
        default:
            mockMsgArray.append(MockMessage(bottom: "", sender: sender, messageId: uniqueID, date: date))
            return mockMsgArray
        
        }
}
}


extension ChatViewController : XMLParserDelegate{
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
    print("attributeDict: \(attributeDict)")
    print("CurrentElementl: \(elementName)")
        if let sessionId = attributeDict["session_id"]{
            UserDefaults.standard.setValue(sessionId, forKey: "SessionId")
        }
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
    print("foundCharacters: \(string)")
    }
}

    


struct ContentStruct{
    var message : String?
    var link : NSDictionary?
    var buttons : NSDictionary?
    var tableCoulumns : NSArray?
    var tableRows : NSArray?
    var responseList : NSArray?
    var responseDict : NSDictionary?
    var messageArray : NSArray?
    var image : UIImage?
    
    
    init(data : NSDictionary){
        print(data)
        responseList = data["response_list"] as? NSArray
        responseDict = responseList?[1] as? NSDictionary
        messageArray = responseDict?["response"] as? NSArray
        message = messageArray?[0] as! String
        buttons = data["buttons"] as? NSDictionary
        link = data["link"] as? NSDictionary
        tableRows = data["table_rows"] as? NSArray
        tableCoulumns = data["table_columns"] as? NSArray
        
    }
}

//AJEET



//struct <#name#> {
//    <#fields#>
//}

// MARK: - MessageCellDelegate

extension ChatViewController: MessageCellDelegate {
    
    func didTapAvatar(in cell: MessageCollectionViewCell) {
        
        print("Avatar tapped")
    }
    
    func didTapMessage(in cell: MessageCollectionViewCell) {
        let indexPath = messagesCollectionView.indexPath(for: cell)
        guard let messagesDataSource = messagesCollectionView.messagesDataSource else {
            fatalError("Ouch. nil data source for messages")
        }
        let message = messagesDataSource.messageForItem(at: indexPath!, in: messagesCollectionView)
        switch message.kind {
        case .video(let media):
            
            let videoURL = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
            let player = AVPlayer(url: videoURL!)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            self.present(playerViewController, animated: true) {
                playerViewController.player!.play()
            }
            print(media.url)
            print(media)
            
        case .photo(let media):
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ImageViewController") as! ImageViewController
            vc.imgUrl = (media.urlStr!)
            self.present(vc, animated: true, completion: nil)
            print(media)
            
        case .location(let location):
            print(location)
            
      

            
        default:
            break
        }
        print("Message tapped")
    }
    
    func didTapCellTopLabel(in cell: MessageCollectionViewCell) {
        print("Top cell label tapped")
    }
    
    func didTapMessageTopLabel(in cell: MessageCollectionViewCell) {
        print("Top message label tapped")
    }
    
    func didTapMessageBottomLabel(in cell: MessageCollectionViewCell) {
        print("Bottom label tapped")
    }
    
    func didTapAccessoryView(in cell: MessageCollectionViewCell) {
        print("Accessory view tapped")
    }
    
}

// MARK: - MessageLabelDelegate

extension ChatViewController: MessageLabelDelegate {
    
    func didSelectAddress(_ addressComponents: [String: String]) {
        print("Address Selected: \(addressComponents)")
    }
    
    func didSelectDate(_ date: Date) {
        print("Date Selected: \(date)")
    }
    
    func didSelectPhoneNumber(_ phoneNumber: String) {
        self.callNumber(phoneNumber: phoneNumber)
        print("Phone Number Selected: \(phoneNumber)")
    }
    
    func didSelectURL(_ url: URL) {
       
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
        print("URL Selected: \(url)")
    }
    
    func didSelectTransitInformation(_ transitInformation: [String: String]) {
        print("TransitInformation Selected: \(transitInformation)")
    }
    
}

// MARK: - MessageInputBarDelegate

extension ChatViewController: MessageInputBarDelegate {
    
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        //inputBar.
        var index:[Int] = []
        for indexPath in self.quickReplyIndexPath {
            index.append(indexPath.item)
        }
        
        print("self.quickReplyIndexPath ===== \(self.quickReplyIndexPath .count)")
          print("self.index ===== \(index)")
        self.isTypedMsg = true
        self.suggestionTable.isHidden = true
        self.messageList.remove(at: index)
        //messagesCollectionView.deleteItems(at: self.quickReplyIndexPath)
          self.sendDataToServer(data: text)
        for component in inputBar.inputTextView.components {
            if let str = component as? String {
                let message = MockMessage(text: str, sender: currentSender(), messageId: UUID().uuidString, date: Date())
                insertMessage(message)
            }
//            } else if let img = component as? UIImage {
//                let message = MockMessage(image: img, sender: currentSender(), messageId: UUID().uuidString, date: Date())
//                insertMessage(message)
//            }
        }
        inputBar.inputTextView.text = String()
        messagesCollectionView.scrollToBottom(animated: true)
    }
    
}
