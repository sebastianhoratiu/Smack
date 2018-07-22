//
//  AvatarCell.swift
//  Smack
//
//  Created by Sebastian Horatiu on 17/07/2018.
//  Copyright © 2018 Sebastian Horatiu. All rights reserved.
//

import UIKit

class AvatarCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarImg: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = 10
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.clipsToBounds = true
    }
}
