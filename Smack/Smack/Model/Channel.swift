//
//  Channel.swift
//  Smack
//
//  Created by Sebastian Horatiu on 09/09/2018.
//  Copyright © 2018 Sebastian Horatiu. All rights reserved.
//

import Foundation

struct Channel {
    public private(set) var channelTitle: String!
    public private(set) var channelDescription: String!
    public private(set) var id: String!
}

//Swift 4 new way of decoding JSON
//properties must have the same names and order as they will come in the JSON response
//struct Channel: Decodable { //Swift 4 new way of decoding JSON
//
//    public private(set) var _id: String!
//    public private(set) var description: String!
//    public private(set) var name: String!
//    public private(set) var __v: Int?
//}
