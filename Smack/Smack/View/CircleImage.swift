//
//  CircleImage.swift
//  Smack
//
//  Created by Sebastian Horatiu on 29/07/2018.
//  Copyright © 2018 Sebastian Horatiu. All rights reserved.
//

import UIKit

@IBDesignable
class CircleImage: UIImageView {
    override func awakeFromNib() {
        self.setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupView()
    }

}
