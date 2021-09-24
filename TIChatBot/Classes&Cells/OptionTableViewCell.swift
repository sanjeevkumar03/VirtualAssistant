//
//  OptionTableViewCell.swift
//  XavBotFramework
//
//  Created by Mac Telus on 07/01/20.
//  Copyright © 2020 Ajeet Sharma. All rights reserved.
//

import UIKit

class OptionTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var optionBtn: UIButton!
    var option:Option?

    override func awakeFromNib() {
        super.awakeFromNib()
        optionBtn.layer.borderColor = UIColor.darkGray.cgColor
        optionBtn.layer.borderWidth = 1
        optionBtn.layer.cornerRadius = 5
         let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(buttonTapped(tapGestureRecognizer:)))
        optionBtn.isUserInteractionEnabled = true
        optionBtn.addGestureRecognizer(tapGestureRecognizer)
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func buttonTapped(tapGestureRecognizer: UITapGestureRecognizer)
       {
        print(self.option!)
        
        let info:[String: Option] = ["option": self.option!]
        
        NotificationCenter.default.post(name: Notification.Name("CarauselOptionButtonTapped"), object: self.option!)

       }
    
    @IBAction func buttonAction() {
           let info:[String: Option] = ["option": self.option!]

           NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CarauselOptionButtonTapped"), object: nil, userInfo: info)
       }
    func configureCell(option:Option, settings:Setting) {
        self.option = option
        optionBtn.setTitle(option.label, for: .normal)
        optionBtn.backgroundColor = settings.button_colour?.hexToUIColor
        optionBtn.setTitleColor(settings.sender_text_icon?.hexToUIColor, for: .normal)
        optionBtn.layer.borderColor = (settings.sender_text_icon?.hexToUIColor)?.cgColor
        optionBtn.titleLabel?.font = .systemFont(ofSize: 12)
       }

    
}
