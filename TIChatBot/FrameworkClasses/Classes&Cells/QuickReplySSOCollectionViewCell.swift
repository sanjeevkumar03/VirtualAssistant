//
//  QuickReplySSOCollectionViewCell.swift
//  XavBotFramework
//
//  Created by Mac Telus on 02/03/20.
//  Copyright © 2020 Ajeet Sharma. All rights reserved.
//

import UIKit

protocol QuickReplySSOCollectionViewCellDelegate {
    func didTappedQuickReplySSOButton(ssoUrl:String)
}

 class QuickReplySSOCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var container: UIView!
    
    var delegate:QuickReplySSOCollectionViewCellDelegate?
    var messageList:[MockMessage]?
    var quickReplyButton:QuickReply?
    var ssoUrl:String?
    

//    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }
    
    open func setupSubviews() {
        //container.roundCorners(corners: [.topLeft, .topRight], radius: 3.0)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
    }
  
    @IBAction func buttonAction(_ sender: Any) {
        print("buutttoTapped")
        self.delegate?.didTappedQuickReplySSOButton(ssoUrl: ssoUrl ?? "")
    }
    
    
    func configure(with messageList: [MockMessage], at indexPath: IndexPath, and messagesCollectionView: MessagesCollectionView, with configuration:Config) {
        container.layer.cornerRadius = 5        
        guard let messagesDataSource = messagesCollectionView.messagesDataSource else {
            fatalError("Ouch. nil data source for messages")
        }
        self.messageList = messageList
        let message = messagesDataSource.messageForItem(at: indexPath, in: messagesCollectionView)
        let settings = configuration.integration?[0].settings
        
        switch message.kind {
        case .quickReplySSO(let quickReplySSOObj):
            titleLabel.text =  quickReplySSOObj.quickReplySSOResponse?.text
            self.quickReplyButton = quickReplySSOObj.quickReplySSOResponse?.quickReplyArray[0]
            button.setTitle((self.quickReplyButton?.text)?.capitalized, for: .normal)
            button.tag = indexPath.section
            button.backgroundColor = settings?.button_colour?.hexToUIColor
            button.setTitleColor(settings?.sender_text_icon?.hexToUIColor, for: .normal)
            button.layer.borderColor = (settings?.sender_text_icon?.hexToUIColor)?.cgColor
            button.titleLabel?.font = .systemFont(ofSize: 12)
            self.createRedirectUrl(ssoAuthUrl: (self.quickReplyButton!.data), redirectUrl: configuration.redirect_url!, botId: configuration.integration![0].bot_id!)
            
        default:
            break
        }
    }
    
    func createRedirectUrl(ssoAuthUrl:String, redirectUrl:String, botId:Int) {
        
        let updatedSsoAuthUrl:String! = ssoAuthUrl.replacingOccurrences(of: "{bot_uid}", with: "1a1WsVdKmnxgpMTZJwzIEJCRJNs")
        print("updatedSsoAuthUrl====\(updatedSsoAuthUrl!)")
        let jidHash = ((UserDefaults.standard.value(forKey: "JiD") as! String) + "_" + (UserDefaults.standard.value(forKey: "SessionId") as! String)).sha1()
        let hashCodeUrl = jidHash + "," + redirectUrl
        let state = hashCodeUrl.toBase64()
        
        let finalSSOUrl = "\(updatedSsoAuthUrl!)" + "&state=" + state
        
        print("finalSSOUrl ===== \(finalSSOUrl)")
        
        self.ssoUrl = finalSSOUrl
        
        
    }
    
}
