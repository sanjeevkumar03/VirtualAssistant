//
//  ChoiceTableViewCell.swift
//  XavBotFramework
//
//  Created by Mac Telus on 27/12/19.
//  Copyright © 2019 Ajeet Sharma. All rights reserved.
//

import UIKit

protocol ChoiceTableViewCellDelegate {
 
    func didTappedChoiceLbl(value:String)

}

class ChoiceTableViewCell: UITableViewCell {

    @IBOutlet weak var choiceTitleLbl: UILabel!
    var delegate:ChoiceTableViewCellDelegate?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(choiceLblTapped(tapGestureRecognizer:)))
                  choiceTitleLbl.isUserInteractionEnabled = true
                  choiceTitleLbl.addGestureRecognizer(tapGestureRecognizer)
        // Initialization code
    }
    
    @objc func choiceLblTapped(tapGestureRecognizer: UITapGestureRecognizer)
       {
        self.delegate?.didTappedChoiceLbl(value: choiceTitleLbl.text!)
           }
         

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
