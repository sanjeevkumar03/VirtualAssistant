//
//  BottomCollectionViewCell.swift
//  XavBotFramework
//
//  Created by Mac Telus on 20/02/20.
//  Copyright © 2020 Ajeet Sharma. All rights reserved.
//

import UIKit

protocol BottomCollectionViewCellDelegate {
    func didTappedThumbButton(thumbType:String)
}


class BottomCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var thumbsDownBtn: UIButton!
    @IBOutlet weak var thumbsUpBtn: UIButton!
    @IBOutlet weak var feedbackContainer: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    
    var delegate:BottomCollectionViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func thumbsDown(_ sender: Any) {
        delegate?.didTappedThumbButton(thumbType: "down")
        print("thumbsDOWN...")
    }
    
    @IBAction func thumbsUp(_ sender: Any) {
        delegate?.didTappedThumbButton(thumbType: "up")
        print("thmbsup...")
    }
    
    func configCell(isFeedback:Bool)  {
        timeLabel.text = getCurrentTime()

        if isFeedback{
            feedbackContainer.isHidden = false
        }
        else{
            feedbackContainer.isHidden = true
        }
        
    }
    
    func getCurrentTime() -> String {
        // get the current date and time
        let currentDateTime = Date()

        // initialize the date formatter and set the style
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .short

        // get the date time String from the date object
        return formatter.string(from: currentDateTime) // October 8, 2016 at 10:48:53 PM
    }
}
