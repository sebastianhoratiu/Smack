//
//  CreateAccountVC.swift
//  Smack
//
//  Created by Sebastian Horatiu on 27/05/2018.
//  Copyright © 2018 Sebastian Horatiu. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view. 
    }
    
    @IBAction func createAccntPressed(_ sender: Any) {
        guard let email = emailTxt.text, emailTxt.text != "" else { return }
        guard let pass = passTxt.text, passTxt.text != "" else { return }
        
        print("Calling registerUser with the following parameters: email = \(email), password = \(pass)")
        
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                print("registered user")
            } else {
                print("not registered user - error")
            }
        }
    }
    @IBAction func pickAvatarPressed(_ sender: Any) {
    }
    @IBAction func pickBGColorPressed(_ sender: Any) {
    }
    
    @IBAction func closeBtnPressed(sender: Any) {
        performSegue(withIdentifier: UNWIND_TO_CHANNEL, sender: nil)
    }

}
