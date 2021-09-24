//
//  FeedbackSurveyVC.swift
//  TagsCollectionView
//
//  Created by Ajeet Sharma on 31/08/20.
//  Copyright © 2020 Telus. All rights reserved.
//

import UIKit

class FeedbackSurveyVC: UIViewController {
    
    @IBOutlet weak var ratingsTitleLblHC: NSLayoutConstraint!
    @IBOutlet weak var ratingsTitleLbl: UILabel!
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    @IBOutlet weak var fourButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    @IBOutlet weak var sixButton: UIButton!
    @IBOutlet weak var sevenButton: UIButton!
    @IBOutlet weak var eightButton: UIButton!
    @IBOutlet weak var nineButton: UIButton!
    @IBOutlet weak var tenButton: UIButton!
    @IBOutlet weak var oneToFiveSV: UIStackView!
    @IBOutlet weak var sixToNineSV: UIStackView!

    


    
    @IBOutlet weak var answerTagsCollView: UICollectionView!
    @IBOutlet weak var answerTagsCollHightConst: NSLayoutConstraint!
    @IBOutlet weak var answersTagContainer: UIView!
    @IBOutlet weak var answersTagTitleLabel: UILabel!
    @IBOutlet weak var answersTagTitleLabelTC: NSLayoutConstraint!
    
    @IBOutlet weak var radioButtonViewContainer: UIView!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var radioButtonViewContainerHC: NSLayoutConstraint!

    @IBOutlet weak var additionalFeedButton: UIButton!
    @IBOutlet weak var feedTextViewContainer: UIView!
    @IBOutlet weak var feedTextView: UITextView!
    @IBOutlet weak var feedTextViewContainerHC: NSLayoutConstraint!
    
    @IBOutlet weak var submitButton: UIButton!

    var ansArray = [String]()
    var selectedIndexPath = IndexPath(item: -1, section: -1)
    var selectedTagIndexPath = IndexPath(item: -1, section: -1)
    var npsSettings:NPSSettings?
    var ratingScale = 0
    var ratingConfig:DataDetails?
    
    var isFeedbackTypeEmoji = false
    var isAdditionalFeedback = false
    var isAnswersTag = false
    var isRadioShow = true
    
    var NavTitleImg:UIImage = UIImage(named: "user1")!
    var navTitleImgView:UIImageView?
    var selectedAnswerTagArr = [IndexPath]()
    var selectedAnswerTagValueArr = [String]()
    var score = 0
    var issuResolved = false

    
    override func viewDidLoad() {
        self.setRatingScale()
        self.setUI()
        self.hideAnswersTag()
        self.setAnswerTag()
        self.hideRadio()
        self.hideAdditionalFeedback()
        self.addNavTitleImage()
       // self.navigationController?.navigationBar.isHidden = true
    }
    
    
           
   override func viewDidAppear(_ animated: Bool) {
       super.viewDidAppear(animated)
    
    }
    
    func addNavTitleImage()  {
        let navHeight = self.navigationController!.navigationBar.frame.size.height - 30
        let navWidth = self.navigationController!.navigationBar.frame.size.width - 50
         navTitleImgView = UIImageView(frame: CGRect(x: 0, y: 0, width: navWidth, height: navHeight))
        navTitleImgView?.contentMode = .scaleAspectFit
         navTitleImgView?.image = self.NavTitleImg
        navigationItem.titleView = navTitleImgView
    }
    
    
    func setRatingScale() {
        if npsSettings?.data?.count ?? 0 > 0{
            self.ratingConfig = npsSettings?.data![0]
        }
        if npsSettings?.rating_scale == "1 to 10"{
            self.ratingScale = 10
            self.sixToNineSV.isHidden = false

        }else if npsSettings?.rating_scale == "1 to 5"{
            self.ratingScale = 5
            self.sixToNineSV.isHidden = true
        }else{
            self.ratingScale = 0
        }
    }
    
    func setUI() {
        self.submitButton.roundedShadowView(cornerRadius: 3, borderWidth: 0, borderColor: .clear)
        npsSettings?.ratings ?? false ? self.showRatingsView():self.HideRatingsView()
        isAnswersTag ? self.showAnswersTag():self.hideAnswersTag()
        npsSettings?.issue_resolved ?? false ? self.showRadio():self.hideRadio()
        npsSettings?.additional_feedback ?? false ? (self.additionalFeedButton.isHidden = false):(self.additionalFeedButton.isHidden = true)
    }
    
    func setAnswerTag()  {
       // if isAnswersTag{
             answerTagsCollView.register(UINib(nibName: "AnsTagsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AnsTagsCollectionViewCell")
            if let flowLayout = self.answerTagsCollView?.collectionViewLayout as? UICollectionViewFlowLayout {
              flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
            }
        //}
    }
    
    
    
    func showRatingsView(){
        self.ratingsTitleLbl.text = (self.ratingConfig?.message?.htmlToString)?.firstCapitalized
        self.ratingsTitleLbl.isHidden = false
        self.ratingsTitleLblHC.constant = 30
        self.npsSettings?.rating_type == "emoji" ? self.setRatingViewAsEmoji():self.setRatingViewAsNumber()
        

    }
    func HideRatingsView(){
           self.ratingsTitleLbl.isHidden = true
           self.ratingsTitleLblHC.constant = 0
       }
    
    func setRatingViewAsEmoji() {
        oneButton.setImage(UIImage(named: "1"), for: .normal)
        twoButton.setImage(UIImage(named: "2"), for: .normal)
        threeButton.setImage(UIImage(named: "3"), for: .normal)
        fourButton.setImage(UIImage(named: "4"), for: .normal)
        fiveButton.setImage(UIImage(named: "5"), for: .normal)
        sixButton.setImage(UIImage(named: "6"), for: .normal)
        sevenButton.setImage(UIImage(named: "7"), for: .normal)
        eightButton.setImage(UIImage(named: "8"), for: .normal)
        nineButton.setImage(UIImage(named: "9"), for: .normal)
        tenButton.setImage(UIImage(named: "10"), for: .normal)
    }
    
    func setRatingViewAsNumber() {
        oneButton.roundedShadowView(cornerRadius: 3, borderWidth: 0, borderColor: .clear)
        oneButton.backgroundColor = UIColor(red: 242/255, green: 239/255, blue: 244/255, alpha: 1)
        oneButton.setTitle("1", for: .normal)
        oneButton.setTitleColor(UIColor(red: 75/255, green: 40/255, blue: 109/255, alpha: 1), for: .normal)
        
        twoButton.roundedShadowView(cornerRadius: 3, borderWidth: 0, borderColor: .clear)
        twoButton.backgroundColor = UIColor(red: 242/255, green: 239/255, blue: 244/255, alpha: 1)
        twoButton.setTitle("2", for: .normal)
        twoButton.setTitleColor(UIColor(red: 75/255, green: 40/255, blue: 109/255, alpha: 1), for: .normal)

        
        threeButton.roundedShadowView(cornerRadius: 3, borderWidth: 0, borderColor: .clear)
        threeButton.backgroundColor = UIColor(red: 242/255, green: 239/255, blue: 244/255, alpha: 1)
        threeButton.setTitle("3", for: .normal)
        threeButton.setTitleColor(UIColor(red: 75/255, green: 40/255, blue: 109/255, alpha: 1), for: .normal)

        
        fourButton.roundedShadowView(cornerRadius: 3, borderWidth: 0, borderColor: .clear)
        fourButton.backgroundColor = UIColor(red: 242/255, green: 239/255, blue: 244/255, alpha: 1)
        fourButton.setTitle("4", for: .normal)
        fourButton.setTitleColor(UIColor(red: 75/255, green: 40/255, blue: 109/255, alpha: 1), for: .normal)

        
        fiveButton.roundedShadowView(cornerRadius: 3, borderWidth: 0, borderColor: .clear)
        fiveButton.backgroundColor = UIColor(red: 242/255, green: 239/255, blue: 244/255, alpha: 1)
        fiveButton.setTitle("5", for: .normal)
        fiveButton.setTitleColor(UIColor(red: 75/255, green: 40/255, blue: 109/255, alpha: 1), for: .normal)

        
        sixButton.roundedShadowView(cornerRadius: 3, borderWidth: 0, borderColor: .clear)
        sixButton.backgroundColor = UIColor(red: 242/255, green: 239/255, blue: 244/255, alpha: 1)
        sixButton.setTitle("6", for: .normal)
        sixButton.setTitleColor(UIColor(red: 75/255, green: 40/255, blue: 109/255, alpha: 1), for: .normal)

        
        sevenButton.roundedShadowView(cornerRadius: 3, borderWidth: 0, borderColor: .clear)
        sevenButton.backgroundColor = UIColor(red: 242/255, green: 239/255, blue: 244/255, alpha: 1)
        sevenButton.setTitle("7", for: .normal)
        sevenButton.setTitleColor(UIColor(red: 75/255, green: 40/255, blue: 109/255, alpha: 1), for: .normal)

        
        eightButton.roundedShadowView(cornerRadius: 3, borderWidth: 0, borderColor: .clear)
        eightButton.backgroundColor = UIColor(red: 242/255, green: 239/255, blue: 244/255, alpha: 1)
        eightButton.setTitle("8", for: .normal)
        eightButton.setTitleColor(UIColor(red: 75/255, green: 40/255, blue: 109/255, alpha: 1), for: .normal)

        
        nineButton.roundedShadowView(cornerRadius: 3, borderWidth: 0, borderColor: .clear)
        nineButton.backgroundColor = UIColor(red: 242/255, green: 239/255, blue: 244/255, alpha: 1)
        nineButton.setTitle("9", for: .normal)
        nineButton.setTitleColor(UIColor(red: 75/255, green: 40/255, blue: 109/255, alpha: 1), for: .normal)

        
        tenButton.roundedShadowView(cornerRadius: 3, borderWidth: 0, borderColor: .clear)
        tenButton.backgroundColor = UIColor(red: 242/255, green: 239/255, blue: 244/255, alpha: 1)
        tenButton.setTitle("10", for: .normal)
        tenButton.setTitleColor(UIColor(red: 75/255, green: 40/255, blue: 109/255, alpha: 1), for: .normal)

       }
    
    func hideAnswersTag()  {
        self.answersTagTitleLabelTC.constant = 0
        self.answerTagsCollHightConst.constant = 0
        self.answersTagTitleLabel.text = ""
        self.answersTagTitleLabel.isHidden = true
        self.answerTagsCollView.isHidden = true
        self.answersTagContainer.isHidden = true
    }
    func showAnswersTag()  {
        let numberOfRows = self.ansArray.count / 3
        print(numberOfRows)
        self.answerTagsCollHightConst.constant = CGFloat(numberOfRows > 0 ? (numberOfRows*70 ): 70)
        self.answerTagsCollView.isHidden = false
        answersTagContainer.isHidden = false
        answersTagTitleLabel.isHidden = false
        answersTagTitleLabelTC.constant = 40
        self.answerTagsCollView.reloadData()
    }
    
    
    func hideRadio()  {
        self.radioButtonViewContainer.isHidden = true
        self.radioButtonViewContainerHC.constant = 0
    }
    func showRadio()  {
        self.radioButtonViewContainer.isHidden = false
        self.radioButtonViewContainerHC.constant = 80
    }
    
    
    func hideAdditionalFeedback() {
        feedTextViewContainer.isHidden = true
        feedTextViewContainerHC.constant = 0
    }
    func showAdditionalFeedback() {
        feedTextView.layer.cornerRadius = 5
        feedTextView.layer.borderWidth = 1
        feedTextView.layer.borderColor = UIColor.lightGray.cgColor
        feedTextViewContainer.isHidden = false
        feedTextViewContainerHC.constant = 160
    }
    
    func didLoadAnswerTags(tag:Int)  {
        self.isAnswersTag = (self.npsSettings?.data?[0].rating_wise_questions?[tag].answer_tags?.count ?? 0) > 0 ? true:false
                      // self.setAnswerTag()
        self.ansArray =  self.npsSettings?.data?[0].rating_wise_questions?[tag].answer_tags ?? [String]()
        self.npsSettings?.data?[0].rating_wise_questions?[tag].answer_tags?.count ?? 0 > 0 ? showAnswersTag():hideAnswersTag()
        self.answersTagTitleLabel.text = (self.npsSettings?.data?[0].rating_wise_questions?[tag].question ?? "").firstCapitalized
               
    }
    
    @IBAction func emojiBtnAction(_ sender: UIButton) {
        self.npsSettings?.issue_resolved ?? false ? self.showRadio():self.hideRadio()
        
        self.npsSettings?.rating_type == "emoji" ? self.setRatingViewAsEmoji():self.setRatingViewAsNumber()
        
        self.npsSettings?.rating_type == "emoji" ? sender.setImage(UIImage(named: "1-f"), for: .normal):(sender.titleLabel?.text = "\(sender.tag + 1)")
        
        self.npsSettings?.rating_type == "emoji" ? (sender.backgroundColor = .clear):(sender.backgroundColor = UIColor(red: 75/255, green: 40/255, blue: 109/255, alpha: 1))
        
        sender.setTitleColor(UIColor.white, for: .normal)
        
        self.didLoadAnswerTags(tag: sender.tag)
        self.selectedAnswerTagArr.removeAll()
        self.selectedAnswerTagValueArr.removeAll()
       
       
        
        switch sender.tag {
            case 0:
                npsSettings?.rating_scale == "1 to 10" ?( score = 1 ):( score = 1*2)
                       print(sender.tag)
            case 1:
                npsSettings?.rating_scale == "1 to 10" ?( score = 2 ):( score = 2*2)

                       print(sender.tag)
            case 2:
                npsSettings?.rating_scale == "1 to 10" ?( score = 3 ):( score = 3*2)

                       print(sender.tag)
            case 3:
                npsSettings?.rating_scale == "1 to 10" ?( score = 4 ):( score = 4*2)

                       print(sender.tag)
            case 4:
                npsSettings?.rating_scale == "1 to 10" ?( score = 5 ):( score = 5*2)

                       print(sender.tag)
            case 5:
                score = 6
                       print(sender.tag)
            case 6:
                score = 7
                       print(sender.tag)
            case 7:
                score = 8
                       print(sender.tag)
            case 8:
                score = 9
                       print(sender.tag)
            case 9:
                score = 10
                       print(sender.tag)

            default:
                       print(sender.tag)

        }

    }
    
    @IBAction func noBtnAction(_ sender: UIButton) {
        noButton.setImage(UIImage(named: "RadioChecked"), for: .normal)
        yesButton.setImage(UIImage(named: "RadioButton"), for: .normal)
        self.issuResolved = false


    }
    
    @IBAction func yesBtnAction(_ sender: UIButton) {
        yesButton.setImage(UIImage(named: "RadioChecked"), for: .normal)
        noButton.setImage(UIImage(named: "RadioButton"), for: .normal)
        self.issuResolved = true
        
    }
    
    @IBAction func additionalFeedbackBtnAction(_ sender: Any) {
        self.showAdditionalFeedback()
    }
    
    @IBAction func submitBtnAction(_ sender: Any) {
//        APIManager.sharedInstance.postTranscript(botId: Assistent.botId, email: emaiTextField.text ?? "", language: Assistent.language, sessionId: (UserDefaults.standard.value(forKey: "SessionId") as! String), user: Assistent.userJid) { (resultStr) in
//            self.showAlert(message: resultStr, title: "Message!")
//        }
        
//        APIManager.sharedInstance.submitNPSSurveyFeedback(reason: self.selectedAnswerTagValueArr, score: self.score, feedback: "", issue_resolved: self.issuResolved) { (resultStr) in
//             self.showAlert(message: resultStr, title: "Message!")
//        }
        
        APIManager.sharedInstance.submitNPSSurveyFeedback(reason: self.selectedAnswerTagValueArr, score: self.score, feedback: "", issue_resolved: self.issuResolved) { (resultStr) in
            DispatchQueue.main.async() {
              self.showAlert(message: resultStr, title: "Message!")            }
                     
        }
    }
    
    @IBAction func closeBtnAction(_ sender: Any) {
                   let transcriptViewController = self.storyboard!.instantiateViewController(withIdentifier: "TranscriptViewController") as! TranscriptViewController
                   transcriptViewController.NavTitleImg = self.navTitleImgView!.image!
                   self.navigationController?.pushViewController(transcriptViewController, animated: true)
    }
    
    
 
}


extension FeedbackSurveyVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
 func numberOfSections(in collectionView: UICollectionView) -> Int {
     // 1
     return 1
 }
 
 func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
 //  if isAnswersTag && (collectionView == answerTagsCollView){
    return self.ansArray.count
//    }
//    return 0
 }
 
 func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//      if isAnswersTag && (collectionView == answerTagsCollView)
//     {
     let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnsTagsCollectionViewCell", for: indexPath) as! AnsTagsCollectionViewCell
    self.selectedAnswerTagArr.contains(indexPath) ? (cell.container.backgroundColor = UIColor(red: 75/255, green: 40/255, blue: 109/255, alpha: 1)):(cell.container.backgroundColor = .clear)
    cell.name.text = "\(ansArray[indexPath.item])"
    cell.container.layer.borderWidth = 1
    cell.container.layer.borderColor = UIColor.lightGray.cgColor
    return cell
//    }
//    
//    return UICollectionViewCell()
    
    
//      else{
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmojiCollectionViewCell", for: indexPath) as! EmojiCollectionViewCell
//            cell.configureCell(index: indexPath, isEmojiUI: true, selectedIndex: self.selectedIndexPath)
//
//            return cell
//   }
 }
 
 
// func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//     if isAnswersTag && (collectionView == answerTagsCollView){
//     let cell = answerTagsCollView.dequeueReusableCell(withReuseIdentifier: "AnsTagsCollectionViewCell", for: indexPath) as! AnsTagsCollectionViewCell
//
//     cell.setNeedsLayout()
//     cell.layoutIfNeeded()
//     let size: CGSize = cell.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
//        return CGSize(width: size.width, height: 30)
//    }
//    print(collectionView.frame.width/5)
//    return CGSize(width: 0, height: 0)
// }
 
 
 func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
     return UIEdgeInsets.zero
 }
 
 func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
     return 5
 }
 
 func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
     return 10
 }
    
func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let selectedItem = collectionView.cellForItem(at: indexPath) as! AnsTagsCollectionViewCell
        self.selectedTagIndexPath = indexPath
        if selectedAnswerTagArr.contains(indexPath){
            selectedAnswerTagArr.remove(at: selectedAnswerTagArr.firstIndex(of: indexPath) ?? -1)
            selectedAnswerTagValueArr.remove(at: selectedAnswerTagValueArr.firstIndex(of: selectedItem.name.text ?? "") ?? -1)
        }else{
            selectedAnswerTagArr.append(indexPath)
            selectedAnswerTagValueArr.append(selectedItem.name.text ?? "")
        }
    print("selectedAnswerTagValueArr === \(selectedAnswerTagValueArr)")
        self.answerTagsCollView.reloadData()
    
     }
    
    
}



extension FeedbackSurveyVC: UITextViewDelegate{
    func textViewDidEndEditing(_ textView: UITextView) {
        print(textView.text)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
