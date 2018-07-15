//
//  UserDataService.swift
//  Smack
//
//  Created by Sebastian Horatiu on 12/07/2018.
//  Copyright © 2018 Sebastian Horatiu. All rights reserved.
//

import Foundation

class UserDataService {
    
    static let instance = UserDataService()
    
    public private(set) var id = ""
    public private(set) var avatarColor = ""
    public private(set) var avatarName = ""
    public private(set) var email = ""
    public private(set) var name = ""
    
    func setUserData(id: String, color: String, avatarName: String, email: String, name: String) {
        print("Inside setUSetUserData with parameters: \(id, color, avatarName,email, name)")
        self.id = id
        self.avatarColor = color
        self.avatarName = avatarName
        self.email = email
        self.name = name
    }
    
    func setAvatarName (avatarName: String) {
        self.avatarName = avatarName
    }
}
