//
//  PropsCollectionViewCell.swift
//  XavBotFramework
//
//  Created by Mac Telus on 20/12/19.
//  Copyright © 2019 Ajeet Sharma. All rights reserved.
//


import UIKit


protocol PropsCollectionViewCellDelegate {
    func didTappedPropsButton(urlStr:String)
}

 class PropsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var propsButton: UIButton!
    @IBOutlet weak var bottomLbl: UILabel!
    
    let button = UIButton()
    var buttonTag = 0
    var delegate:PropsCollectionViewCellDelegate?
    var messageList:[MockMessage]?
    var prop:Prop?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }
    
    open func setupSubviews() {
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    @objc func didTappedButton() {
//        switch messageList![button.tag].kind {
//        case .quickReplyButton(let butn):
//            delegate?.didTappedQuickReplyButton(type: butn.quickReplyButton!.type, text: butn.quickReplyButton!.text)
//        default:
//            break
//        }
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        self.delegate?.didTappedPropsButton(urlStr: self.prop!.onesource)
    print("Button Tapped")
    }
    

    
    func configure(with messageList: [MockMessage], at indexPath: IndexPath, and messagesCollectionView: MessagesCollectionView, with configuration:Setting) {
        
        guard let messagesDataSource = messagesCollectionView.messagesDataSource else {
            fatalError("Ouch. nil data source for messages")
        }
        self.messageList = messageList
        let message = messagesDataSource.messageForItem(at: indexPath, in: messagesCollectionView)
        switch message.kind {
        case .prop(let prop):
            self.prop = prop.prop 
//            button.setTitle((butn.quickReplyButton?.text)?.capitalized, for: .normal)
//            button.tag = indexPath.section
//            button.backgroundColor = configuration.button_colour?.hexToUIColor
//            button.setTitleColor(configuration.sender_text_icon?.hexToUIColor, for: .normal)
//            button.titleLabel?.font = .systemFont(ofSize: 12)

        default:
            break
        }
    }
}
