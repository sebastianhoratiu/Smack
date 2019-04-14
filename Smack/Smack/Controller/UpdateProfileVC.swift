//
//  UpdateProfileVC.swift
//  Smack
//
//  Created by Sebastian Horatiu on 03/03/2019.
//  Copyright © 2019 Sebastian Horatiu. All rights reserved.
//

import UIKit

class UpdateProfileVC: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var updateProfileBtn: RoundedButton!
    
    //MARK: Variables
    var avatarName = "profileDefault"
    var avatarColor = DEFAULT_AVATAR_COLOR
    var bgColor: UIColor?
    var originalUserImg: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("***** Update profile VC: view did load \n*****")
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("***** Update profile VC: view did appear \n*****")
    }
    
    @IBAction func pickAvatarPressed(_ sender: Any) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let avatarPicker = mainStoryboard.instantiateViewController(withIdentifier: "AvatarPicker")
        avatarPicker.modalPresentationStyle = .custom
        present(avatarPicker, animated: true, completion: nil)
    }
    
    @IBAction func generateBGColoPressed(_ sender: Any) {
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
    
    @IBAction func updateProfilePressed(_ sender: Any) {
        guard let name = usernameTxt.text, usernameTxt.text != "" else { return }
        guard let email = emailTxt.text, emailTxt.text != "" else { return }
        
        AuthService.instance.updateUserById(name: name, email: email, avatarName: avatarName, avatarColor: avatarColor, userId: UserDataService.instance.id) { (success) in
            if success {
                    AuthService.instance.findUserById { (success) in
                        if success {
                            NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                        }
                    }
                self.dismiss(animated: true, completion: nil)
            } else {
                print("udpateUser ran into some error?")
                print("The description of success is: \(success.description)")
            }
        }
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func usernameChanged(_ sender: Any) {
        print("***** \n username - Editing Changed! \n*****")
    }
    
    @IBAction func profileValuesDidEndEditing(_ sender: Any) {
        print("***** \n username - Editing Did End! \n*****")
        if usernameTxt.text != UserDataService.instance.name || emailTxt.text != UserDataService.instance.email || userImg.image != originalUserImg || avatarColor != UserDataService.instance.avatarColor {
            enableUpdateProfileBtn()
            print("***** \n UpdateProfileBtn should be enabled! \n*****")
        } else {
            disableUpdateProfileBtn()
            print("***** \n UpdateProfileBtn should be disabled \n*****")
        }
    }
    
    @IBAction func usernameValueChanged(_ sender: Any) {
        print("***** \n username - Value Changed! \n*****")
    }
    
    func disableUpdateProfileBtn() {
        if updateProfileBtn.isUserInteractionEnabled == true {
            updateProfileBtn.isUserInteractionEnabled = false
            updateProfileBtn.alpha = 0.5
        }
        
    }
    
    func enableUpdateProfileBtn() {
        if updateProfileBtn.isUserInteractionEnabled == false {
            updateProfileBtn.isUserInteractionEnabled = true
            updateProfileBtn.alpha = 1
        }
    }
    
    func setupView() {
        usernameTxt.text = UserDataService.instance.name
        emailTxt.text = UserDataService.instance.email
        
        avatarName = UserDataService.instance.avatarName
        originalUserImg = UIImage(named: avatarName)
        print("setupView - originalUserImg: \(originalUserImg)")
        userImg.image = originalUserImg
        
        avatarColor = UserDataService.instance.avatarColor
        userImg.backgroundColor = UserDataService.instance.returnUIColor(components: avatarColor)
        
        spinner.isHidden = true
        disableUpdateProfileBtn()
        
        // Be able to dismiss the keyboard when you tap anywhere in the view
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }

}
