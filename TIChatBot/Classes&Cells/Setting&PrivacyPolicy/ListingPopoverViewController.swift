//
//  ListingPopoverViewController.swift
//  XavBotFramework
//
//  Created by Ajeet Sharma on 23/11/20.
//  Copyright © 2020 Ajeet Sharma. All rights reserved.
//

import Foundation
import UIKit

protocol ListingPopoverVCDelegate {
    func didSelectectlanguage(index:Int, language:Language)
    func didSelectectWeb(index:Int, webName:String)

}


class ListingPopoverViewController: UIViewController {

    var delegate:ListingPopoverVCDelegate?
    var languageArray = [Language]()
    var channelArray = ["Web", "Mobile"]
    var isChannelSelected = false

        override func viewDidLoad() {
            super.viewDidLoad()
            self.view.backgroundColor = UIColor.clear

        }
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        }
    }


extension ListingPopoverViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isChannelSelected ? self.channelArray.count:self.languageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListCell
        cell.titleLabel.text = isChannelSelected ? self.channelArray[indexPath.row] : self.languageArray[indexPath.row].displayName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        isChannelSelected ?  self.delegate?.didSelectectWeb(index: indexPath.row, webName: self.channelArray[indexPath.row]):self.delegate?.didSelectectlanguage(index: indexPath.row, language: self.languageArray[indexPath.row])
    }

    
}
