//
//  AnsTagsCollectionViewCell.swift
//  TagsCollectionView
//
//  Created by Ajeet Sharma on 07/09/20.
//  Copyright © 2020 Telus. All rights reserved.
//

import UIKit

class AnsTagsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var container: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.container.layer.cornerRadius = 3
        container.layer.masksToBounds = true    }

}
