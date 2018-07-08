//
//  AuthService.swift
//  Smack
//
//  Created by Sebastian Horatiu on 24/06/2018.
//  Copyright © 2018 Sebastian Horatiu. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthService {
    static let instance = AuthService()
    
    let defaults = UserDefaults.standard
    
    var isLoggedIn: Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    var authToken: String {
        get {
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail: String {
        get {
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    func registerUser(email: String, password: String, completion: @escaping CompletionHandler) {
        let lowerCaseEmail = email.lowercased()
        let header = ["Content-Type": "application/json; charset=utf-8"]
        let body: [String: Any] = ["email": lowerCaseEmail,
                                   "password": password]
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseString { (response) in
            if response.result.error == nil {
                completion(true)
                print("Url: \(URL_REGISTER), parameters: \(body), headers: \(header)")
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func loginUser(email: String, password: String, completion: @escaping CompletionHandler) {
        let lowerCaseEmail = email.lowercased()
        let body: [String: Any] = ["email": lowerCaseEmail,
                                   "password": password]
        
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if response.result.error == nil {
                if let json = response.result.value as? Dictionary<String, Any> {
                    print("Response.value: \(json)")
                    print("Response.data: \(response.data)")
                    // The old/standard way of parsing JSON
//                    if let email = json["user"] as? String {
//                        print("Response.value.user: \(email)")
//                        self.userEmail = email
//                    }
//                    if let token = json["token"] as? String {
//                        print("Response.value.token: \(token)")
//                        self.authToken = token
//                    }
                    
                    // Using SwiftyJSON
                       // it didn't work this way without exception handling
//                    guard let data = response.data else { return }
//                    let json = JSON(data: data)
                    
                    guard let data = response.result.value else { return }
                    let json = JSON(data)
                    self.userEmail = json["user"].stringValue
                    self.authToken = json["token"].stringValue
                }
                self.isLoggedIn = true
                completion(true)
            } else {
                completion(false)
                print(response.result.error as Any)
            }
        }
        
    }
    
}
