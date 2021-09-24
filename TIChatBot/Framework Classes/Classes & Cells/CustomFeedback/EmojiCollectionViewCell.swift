//
//  EmojiCollectionViewCell.swift
//  TagsCollectionView
//
//  Created by Ajeet Sharma on 07/09/20.
//  Copyright © 2020 Telus. All rights reserved.
//

import UIKit

class EmojiCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var emojiBtn: UIButton!
    
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
   
    
    func configureCell(index:IndexPath, isEmojiUI:Bool, selectedIndex:IndexPath){
        if isEmojiUI{
            emojiBtn.titleLabel?.text = ""
            selectedIndex == index ? (emojiBtn.setBackgroundImage(UIImage(named: "\(index.item + 1)-f"), for: .normal)) : (emojiBtn.setBackgroundImage(UIImage(named: "\(index.item + 1)"), for: .normal))
            
        }else{
            emojiBtn.layer.cornerRadius = 5
            emojiBtn.layer.borderWidth = 1
            emojiBtn.layer.borderColor = UIColor.lightGray.cgColor
            emojiBtn.layer.masksToBounds = true
            emojiBtn.setTitle("\(index.item + 1)", for: .normal)
            selectedIndex == index ? (emojiBtn.backgroundColor = UIColor.purple) : (emojiBtn.backgroundColor = UIColor.clear)
        }
    }
  

}
