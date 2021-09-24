//
//  SettingViewControllerViewController.swift
//  XavBotFramework
//
//  Created by Ajeet Sharma on 19/10/20.
//  Copyright © 2020 Ajeet Sharma. All rights reserved.
//

import UIKit

class SettingViewControllerViewController: UIViewController {
    @IBOutlet weak var channelContainer: UIView!
    @IBOutlet weak var languageContainer: UIView!
    @IBOutlet weak var languagelabel: UILabel!
    @IBOutlet weak var channellabel: UILabel!
    var languageArray = [Language]()
    var languageSelected = ""
    var channelSelected = ""
    
    var NavTitleImg:UIImage = UIImage(named: "user1")!
    var navTitleImgView:UIImageView?

    override func viewDidLoad() {
        super.viewDidLoad()
       // self.navigationItem.title = "Settings"
        self.addNavTitleImage()
        self.channelContainer.roundedShadowView(cornerRadius: 5, borderWidth: 1, borderColor: .darkGray)
        self.languageContainer.roundedShadowView(cornerRadius: 5, borderWidth: 1, borderColor: .darkGray)

        // Do any additional setup after loading the view.
    }
    
    func addNavTitleImage()  {
        let navHeight = self.navigationController!.navigationBar.frame.size.height - 30
        let navWidth = self.navigationController!.navigationBar.frame.size.width - 50
         navTitleImgView = UIImageView(frame: CGRect(x: 0, y: 0, width: navWidth, height: navHeight))
        navTitleImgView?.contentMode = .scaleAspectFit
         navTitleImgView?.image = self.NavTitleImg
        navigationItem.titleView = navTitleImgView
    }
    
    @IBAction func channelBtnClicked(_ sender: UIButton) {
        self.presentListingPopover(forChannel: true, sender: sender)
    }
    
    @IBAction func languageBtnClicked(_ sender: UIButton) {
        self.presentListingPopover(forChannel: false, sender: sender)

    }
    
    func presentListingPopover(forChannel:Bool, sender: UIButton) {
       // if let button = sender as? UIBarButtonItem {
            let popoverContentController = self.storyboard!.instantiateViewController(withIdentifier: "ListingPopoverViewController") as! ListingPopoverViewController
            popoverContentController.modalPresentationStyle = .popover
        popoverContentController.preferredContentSize = CGSize(width: 300, height: forChannel ? 100: (self.languageArray.count * 30 + 20 ))
            popoverContentController.delegate = self
            print(self.languageArray)
            popoverContentController.languageArray = self.languageArray
            popoverContentController.isChannelSelected = forChannel

            
            if let popoverPresentationController = popoverContentController.popoverPresentationController {
                   popoverPresentationController.permittedArrowDirections = .up
                   popoverPresentationController.backgroundColor = UIColor.black.withAlphaComponent(0.65)
                   popoverPresentationController.sourceView = sender
                  // popoverPresentationController.barButtonItem = button
                   popoverPresentationController.delegate = self
                   present(popoverContentController, animated: true, completion: nil)
               }
     //   }
    }
  
}


extension SettingViewControllerViewController: ListingPopoverVCDelegate, UIPopoverPresentationControllerDelegate {
    func didSelectectlanguage(index: Int, language: Language) {
        print(language.displayName)
        self.languageSelected = language.lang ?? ""
        self.languagelabel.text = language.displayName
        dismiss(animated: true, completion: nil)
    }
    
    func didSelectectWeb(index: Int, webName: String) {
        print(webName)
        self.channellabel.text = webName
        self.channelSelected = webName
        dismiss(animated: true, completion: nil)
    }
    
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    //UIPopoverPresentationControllerDelegate
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
    }
    
    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return true
    }
    
}
