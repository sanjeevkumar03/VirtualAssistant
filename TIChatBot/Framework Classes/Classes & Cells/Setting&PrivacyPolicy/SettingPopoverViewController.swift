//
//  SettingPopoverViewController.swift
//  XavBotFramework
//
//  Created by Ajeet Sharma on 19/10/20.
//  Copyright © 2020 Ajeet Sharma. All rights reserved.
//

import UIKit

protocol SettingPopoverVCDelegate {
    func didSelectectOption(index:Int)
}


class SettingPopoverViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    var delegate:SettingPopoverVCDelegate?

        override func viewDidLoad() {
            super.viewDidLoad()
            self.view.backgroundColor = UIColor.clear
        }
    
    @IBAction func settingBtnClicked(_ sender: UIButton) {
        self.delegate?.didSelectectOption(index: 0)
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func privacyPolicyBtnClicked(_ sender: UIButton) {
        self.delegate?.didSelectectOption(index: 1)
        self.dismiss(animated: false, completion: nil)
    }
   
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        }
    }
