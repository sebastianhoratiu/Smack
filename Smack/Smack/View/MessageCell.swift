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
        
        // 2017-07-13T21:49:25.590Z - this is the ISO8601 date we're getting from the API
        // But Apple does not handle very well the milliseconds part of it
        // So we have to convert it somehow to 2017-07-13T21:49:25Z
        
        guard var isoDate = message.timeStamp else { return }
        let toIndex = isoDate.index(isoDate.endIndex, offsetBy: -6)
        //isoDate = isoDate.substring(to: toIndex)
        //'substring(to:)' is deprecated: Please use String slicing subscript with a 'partial range upto' operator.
        //This would be Swift 4 way to do it
        isoDate = String(isoDate[...toIndex])
        
        let isoFormatter = ISO8601DateFormatter()
        let chatDate = isoFormatter.date(from: isoDate.appending("Z"))
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, hh:mm a"
        
        if let isoChatDate = chatDate {
            let finalDate = dateFormatter.string(from: isoChatDate)
            timeStampLbl.text = finalDate
        }
    }

}
