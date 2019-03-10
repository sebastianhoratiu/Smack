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
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var updateProfileBtn: RoundedButton!
    
    
    //MARK: Variables
    var avatarName = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    var bgColor: UIColor?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
    }

    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func usernameChanged(_ sender: Any) {
        print("***** \n username - Editing Changed! \n*****")
    }
    
    @IBAction func profileValuesDidEndEditing(_ sender: Any) {
        print("***** \n username - Editing Did End! \n*****")
        if usernameTxt.text != UserDataService.instance.name || emailTxt.text != UserDataService.instance.email {
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
    
    
    fileprivate func disableUpdateProfileBtn() {
        if updateProfileBtn.isUserInteractionEnabled == true {
            updateProfileBtn.isUserInteractionEnabled = false
            updateProfileBtn.alpha = 0.5
        }
        
    }
    
    fileprivate func enableUpdateProfileBtn() {
        if updateProfileBtn.isUserInteractionEnabled == false {
            updateProfileBtn.isUserInteractionEnabled = true
            updateProfileBtn.alpha = 1
        }
    }
    
    func setupView() {
        usernameTxt.text = UserDataService.instance.name
        emailTxt.text = UserDataService.instance.email
        userImg.image = UIImage(named: UserDataService.instance.avatarName)
        userImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        spinner.isHidden = true
        disableUpdateProfileBtn()
        
        // Be able to dismiss the keyboard when you tap anywhere in the view
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }

}
