//
//  MessageCell.swift
//  Smack
//
//  Created by Sebastian Horatiu on 25/11/2018.
//  Copyright © 2018 Sebastian Horatiu. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    
    // MARK: IBOutlets
    @IBOutlet weak var userImg: CircleImage!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var timeStampLbl: UILabel!
    
    @IBOutlet weak var messageBodyLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(message: Message) {
        messageBodyLbl.text = message.messageBody
        userNameLbl.text = message.userName
        userImg.image = UIImage(named: message.userAvatar)
        userImg.backgroundColor = UserDataService.instance.returnUIColor(components: message.userAvatarColor)
    }

}
