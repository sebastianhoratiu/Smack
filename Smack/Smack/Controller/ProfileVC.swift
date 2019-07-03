//
//  ProfileVC.swift
//  Smack
//
//  Created by Sebastian Horatiu on 19/08/2018.
//  Copyright © 2018 Sebastian Horatiu. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    //Mark: Outlets
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    @IBAction func updateProfilePressed(_ sender: Any) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let createAccountVC = mainStoryBoard.instantiateViewController(withIdentifier: "CreateAccount")
        createAccountVC.modalPresentationStyle = .custom
        present(createAccountVC, animated: true, completion: nil)
    }
    
    @IBAction func closeModalPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            UserDataService.instance.logoutUser()
            NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            dismiss(animated: true, completion: nil)
        }
    }
    
    fileprivate func setupView() {
        userName.text = UserDataService.instance.name
        userEmail.text = UserDataService.instance.email
        profileImg.image = UIImage(named: UserDataService.instance.avatarName)
        profileImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        
        //The below implementation, similar to the one in CreateAccountVC does not seem to work here
//        let tap = UITapGestureRecognizer(target: self.bgView, action: #selector(UIView.resignFirstResponder))
//        tap.cancelsTouchesInView = false
//        self.bgView.addGestureRecognizer(tap)
        
        //Implementation from the course
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(self.closeTap(_:)))
        self.bgView.addGestureRecognizer(closeTouch)
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
}
