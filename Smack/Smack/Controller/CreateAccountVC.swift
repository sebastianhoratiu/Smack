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
    @IBOutlet weak var titleTxt: UILabel!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var createAccountBtn: RoundedButton!
    @IBOutlet weak var passLine: UIView!
    
    
    
    //MARK: Variables
    var avatarName = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    var bgColor: UIColor?
    
    override func viewWillAppear(_ animated: Bool) {
        if (presentingViewController as? ProfileVC) != nil {
            setupUpdateView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != "" && UserDataService.instance.avatarColor == "" {
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            avatarName = UserDataService.instance.avatarName

            // Set a default background color for when a light avatar is selected, so that it is better visible
            if avatarName.contains("light") && bgColor == nil {
                userImg.backgroundColor = UIColor.lightGray
            } else if avatarName.contains("dark") && bgColor == nil{
                userImg.backgroundColor = UIColor.clear
            }
        }
    }
    
    @IBAction func createAccntPressed(_ sender: Any) {
        spinner.isHidden = false
        spinner.startAnimating()
        
        guard let name = usernameTxt.text, usernameTxt.text != "" else { return }
        guard let email = emailTxt.text, emailTxt.text != "" else { return }
        guard let pass = passTxt.text, passTxt.text != "" else { return }
        
        print("Calling registerUser with the following parameters: email = \(email), password = \(pass)")
        
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                print("registered user")
                AuthService.instance.loginUser(email: email, password: pass, completion: { (success) in
                    if success {
                        print("Logged in user!", "AuthToken: \(AuthService.instance.authToken)")
                        print("Calling createUser with the following parameters: \(name, email, self.avatarName, self.avatarColor)")
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            if success {
                                self.spinner.isHidden = true
                                self.spinner.stopAnimating()
                                
                                print("createUser - Success!")
                                print(UserDataService.instance.name, UserDataService.instance.avatarName)
                                self.performSegue(withIdentifier: UNWIND_TO_CHANNEL, sender: nil)
                                
                                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                            } else {
                                self.spinner.isHidden = true
                                self.spinner.stopAnimating()
                                
                                print("createUser ran into some error?")
                                print("The description of success is: \(success.description)")
                            }
                        })
                    }
                })
            } else {
                print("not registered user - error")
            }
        }
    }
    @IBAction func pickAvatarPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
    @IBAction func pickBGColorPressed(_ sender: Any) {
        let r = CGFloat(arc4random_uniform(255)) / 255
        let g = CGFloat(arc4random_uniform(255)) / 255
        let b = CGFloat(arc4random_uniform(255)) / 255
        
        bgColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        //It seems this is done in a very complicated way.
        //Why don't we just set avatarColor to be of type UIColor
        //and just pass the value of bgColor to it.
        //Just a question I have, I don't know if this would actually work.
        avatarColor = "[\(r), \(g), \(b), 1]"
        
        // Animate the transition from one background color to another
        UIView.animate(withDuration: 0.2) {
            self.userImg.backgroundColor = self.bgColor
        }
        
    }
    
    @IBAction func closeBtnPressed(sender: Any) {
        if (presentingViewController as? ProfileVC) != nil {
            dismiss(animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: UNWIND_TO_CHANNEL, sender: nil)
        }
    }
    
    func setupView() {
        spinner.isHidden = true
        
        usernameTxt.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedString.Key.foregroundColor : smackPurplePlaceholder])
        emailTxt.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedString.Key.foregroundColor : smackPurplePlaceholder])
        passTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor : smackPurplePlaceholder])
        
        // Very similar implementation in lecture 77 but, the below one I found on Medium seems better
        // Be able to dismiss the keyboard when you tap anywhere in the view
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    func setupUpdateView() {
        titleTxt.text = "Update Profile"
        createAccountBtn.setTitle("Update Profile", for: .normal)
        
        usernameTxt.text = UserDataService.instance.name
        emailTxt.text = UserDataService.instance.email
        userImg.image = UIImage(named: UserDataService.instance.avatarName)
        userImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        passTxt.isHidden = true
        passLine.isHidden = true
    }

}
