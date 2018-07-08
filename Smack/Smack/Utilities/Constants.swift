//
//  Constants.swift
//  Smack
//
//  Created by Sebastian Horatiu on 27/05/2018.
//  Copyright © 2018 Sebastian Horatiu. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success: Bool) -> ()

//MARK: URL constants
let BASE_URL = "https://slackchatcloneseb.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"

//MARK: Segues
let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND_TO_CHANNEL = "unwindToChannel"

//MARK: User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

//MARK: Headers
let HEADER = ["Content-Type": "application/json; charset=utf-8"]
