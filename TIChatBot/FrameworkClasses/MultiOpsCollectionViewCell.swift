//
//  MultiOpsCollectionViewCell.swift
//  XavBotFramework
//
//  Created by Mac Telus on 27/12/19.
//  Copyright © 2019 Ajeet Sharma. All rights reserved.
//

import UIKit

protocol MultiOpsCollectionViewCellDelegate {
    func didTappedMoreOptionButton(choices:[Choice])
    func didTappedChoice(value:String)

}

class MultiOpsCollectionViewCell: UICollectionViewCell, ChoiceTableViewCellDelegate {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var button: UIButton!
    
    var delegate:MultiOpsCollectionViewCellDelegate?
    var messageList:[MockMessage]?
    var multiOps:MultiOps?
    
    override func awakeFromNib() {
        super.awakeFromNib()
   containerView.layer.cornerRadius = 10
   tableView.register(UINib(nibName: "ChoiceTableViewCell", bundle: nil), forCellReuseIdentifier: "ChoiceTableViewCell")
      
    }
    
    
    func didTappedChoiceLbl(value:String){
         self.delegate?.didTappedChoice(value: value)
    }
        
    func configure(with messageList: [MockMessage], at indexPath: IndexPath, and messagesCollectionView: MessagesCollectionView, with configuration:Setting) {
            
            guard let messagesDataSource = messagesCollectionView.messagesDataSource else {
                fatalError("Ouch. nil data source for messages")
            }
            self.messageList = messageList
            let message = messagesDataSource.messageForItem(at: indexPath, in: messagesCollectionView)
            switch message.kind {
            case .multiOps(let multiOpsProtocol):
                self.multiOps = multiOpsProtocol.multiOps
                self.titleLbl.text = "  \(self.multiOps!.text)"
                self.containerView.backgroundColor = configuration.response_bubble?.hexToUIColor
                self.titleLbl.textColor = configuration.response_text_icon?.hexToUIColor
                self.button.setTitleColor(configuration.response_text_icon?.hexToUIColor, for: .normal) 

            default:
                break
            }
        }

    @IBAction func buttonAction(_ sender: Any) {
        self.delegate?.didTappedMoreOptionButton(choices: self.multiOps!.choices)
    }
}



extension MultiOpsCollectionViewCell:UITableViewDelegate, UITableViewDataSource{
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2 //self.multiOps?.options_limit ?? 0
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChoiceTableViewCell", for: indexPath) as! ChoiceTableViewCell
        cell.choiceTitleLbl.text = self.multiOps?.choices[indexPath.row].label
        cell.delegate = self

        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
     //   self.delegate?.didTappedChoice(choices: (self.multiOps?.choices[indexPath.row])!)
      // Do here
    }

}
