//
//  ChannelVC.swift
//  Smack
//
//  Created by Sebastian Horatiu on 13/05/2018.
//  Copyright © 2018 Sebastian Horatiu. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // The defaul in the version I'm using is 260 which already looks great
//        print(self.revealViewController().rearViewRevealWidth)
        // But I'll implement the dynamic with as in course, to be consistent
        self.revealViewController().rearViewRevealWidth = self.view.frame.width - 60
        
        
    }



}
