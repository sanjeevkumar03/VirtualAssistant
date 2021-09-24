//
//  NormalFeedbackVC.swift
//  TagsCollectionView
//
//  Created by Ajeet Sharma on 09/09/20.
//  Copyright © 2020 Telus. All rights reserved.
//

import UIKit

class NormalFeedbackVC: UIViewController {

        @IBOutlet weak var emj3Button: UIButton!
        @IBOutlet weak var emj2Button: UIButton!
        @IBOutlet weak var emj1Button: UIButton!
    
        @IBOutlet weak var addButton: UIButton!
        @IBOutlet weak var submitButton: UIButton!

        @IBOutlet weak var feedTextViewContainer: UIView!
        @IBOutlet weak var feedTextView: UITextView!
       // @IBOutlet weak var feedTextViewContainerHC: NSLayoutConstraint!

        var isAdditionalFeedback = false
        var NavTitleImg:UIImage = UIImage(named: "user1")!
        var navTitleImgView:UIImageView?

        
        override func viewDidLoad() {
            self.addNavTitleImage()
            isAdditionalFeedback ? self.showAdditionalFeedback():self.hideAdditionalFeedback()
            submitButton.roundedShadowView(cornerRadius: 5, borderWidth: 1, borderColor: .lightGray)
            self.navigationController?.navigationBar.isHidden = false

        }
    
    func addNavTitleImage()  {
        let navHeight = self.navigationController!.navigationBar.frame.size.height - 30
        let navWidth = self.navigationController!.navigationBar.frame.size.width - 50
         navTitleImgView = UIImageView(frame: CGRect(x: 0, y: 0, width: navWidth, height: navHeight))
        navTitleImgView?.contentMode = .scaleAspectFit
         navTitleImgView?.image = self.NavTitleImg
        navigationItem.titleView = navTitleImgView
    }
       
        func hideAdditionalFeedback() {
            feedTextViewContainer.isHidden = true
        }
        
        func showAdditionalFeedback() {
            feedTextView.roundedShadowView(cornerRadius: 5, borderWidth: 1, borderColor: UIColor.lightGray)
            feedTextViewContainer.isHidden = false
        }
        
        @IBAction func emojiBtnAction(_ sender: UIButton) {
            submitButton.backgroundColor = UIColor(red: 85, green: 21, blue: 110, alpha: 1)
            switch sender.tag {
            case 0:
                print("")
                emj1Button.setBackgroundImage(UIImage(named: "4-f"), for: .normal)
                emj2Button.setBackgroundImage(UIImage(named: "6"), for: .normal)
                emj3Button.setBackgroundImage(UIImage(named: "7"), for: .normal)

            case 1:
                print("")
                emj1Button.setBackgroundImage(UIImage(named: "4"), for: .normal)
                emj2Button.setBackgroundImage(UIImage(named: "6-f"), for: .normal)
                emj3Button.setBackgroundImage(UIImage(named: "7"), for: .normal)
            case 2:
                print("")
                emj1Button.setBackgroundImage(UIImage(named: "4"), for: .normal)
                emj2Button.setBackgroundImage(UIImage(named: "6"), for: .normal)
                emj3Button.setBackgroundImage(UIImage(named: "7-f"), for: .normal)
            default:
                print("")
            }

           }
        
        
        @IBAction func additionalFeedbackBtnAction(_ sender: Any) {
            self.showAdditionalFeedback()
        }
        
        @IBAction func submitBtnAction(_ sender: Any) {
        }
        
        @IBAction func closeBtnAction(_ sender: Any) {
            let transcriptViewController = self.storyboard!.instantiateViewController(withIdentifier: "TranscriptViewController") as! TranscriptViewController
            transcriptViewController.NavTitleImg = self.navTitleImgView!.image!
            self.navigationController?.pushViewController(transcriptViewController, animated: true)
        }
        
        
     
    }


   
    extension NormalFeedbackVC: UITextViewDelegate{
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
