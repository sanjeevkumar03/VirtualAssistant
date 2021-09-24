//
//  TranscriptViewController.swift
//  TagsCollectionView
//
//  Created by Ajeet Sharma on 09/09/20.
//  Copyright © 2020 Telus. All rights reserved.
//

import UIKit

class TranscriptViewController: UIViewController {
     @IBOutlet weak var emaiTextField: UITextField!
     @IBOutlet weak var TopTitle: UILabel!
     @IBOutlet weak var transcriptTitle: UILabel!
     @IBOutlet weak var transcriptDesc: UILabel!
     @IBOutlet weak var closeButton: UIButton!
     @IBOutlet weak var emailContainer: UIView!
    
    var NavTitleImg:UIImage = UIImage(named: "user1")!
    var navTitleImgView:UIImageView?
    

           override func viewDidLoad() {
            self.addNavTitleImage()
            //self.navigationController?.navigationBar.isHidden = true
            emailContainer.roundedShadowView(cornerRadius: 3, borderWidth: 1, borderColor: .lightGray)

           }
    
    func addNavTitleImage()  {
        let navHeight = self.navigationController!.navigationBar.frame.size.height - 30
        let navWidth = self.navigationController!.navigationBar.frame.size.width - 50
         navTitleImgView = UIImageView(frame: CGRect(x: 0, y: 0, width: navWidth, height: navHeight))
        navTitleImgView?.contentMode = .scaleAspectFit
         navTitleImgView?.image = self.NavTitleImg
        navigationItem.titleView = navTitleImgView
    }
         
           @IBAction func sendBtnAction(_ sender: Any) {
            APIManager.sharedInstance.postTranscript(botId: Assistent.botId, email: emaiTextField.text ?? "", language: Assistent.language, sessionId: (UserDefaults.standard.value(forKey: "SessionId") as! String), user: Assistent.userJid) { (resultStr) in
                DispatchQueue.main.async() {
                self.showAlert(message: resultStr, title: "Message!")            }
            }
           }
           
           @IBAction func closeBtnAction(_ sender: Any) {
           }
        
    
}

       extension TranscriptViewController: UITextFieldDelegate{
        func textFieldDidEndEditing(_ textField: UITextField) {
             print(textField.text)
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.view.endEditing(true)
            return false
        }
        
       }
