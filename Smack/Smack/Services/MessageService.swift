//
//  MessageService.swift
//  Smack
//
//  Created by Sebastian Horatiu on 09/09/2018.
//  Copyright © 2018 Sebastian Horatiu. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    
    //Make it a singleton
    static let instance = MessageService()
    
    var channels = [Channel]()
    var selectedChannel: Channel?
    
    func findAllChannels(completion: @escaping CompletionHandler) {
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                if let json = JSON(data).array {
                    for item in json {
                        let name = item["name"].stringValue
                        let description = item["description"].stringValue
                        let id = item["_id"].stringValue
                        
                        let channel = Channel(channelTitle: name, channelDescription: description, id: id)
                        self.channels.append(channel)
                    }
                    
                    //Swift 4 new way of decoding JSON
                    //                do {
                    //                    self.channels = try JSONDecoder().decode([Channel].self, from: data)
                    //                } catch let error {
                    //                    debugPrint(error)
                    //                }
                }
                print("These are all the available channels: \(self.channels)")
                
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func clearChannels() {
        channels.removeAll()
    }
}

