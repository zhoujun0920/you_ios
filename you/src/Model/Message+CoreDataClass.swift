//
//  Message+CoreDataClass.swift
//  you
//
//  Created by Jun Zhou on 10/22/18.
//  Copyright © 2018 jzhou. All rights reserved.
//
//

import Foundation
import CoreData
import Firebase
import SwiftyJSON

@objc(Message)
public class Message: NSManagedObject {
    func fromJSON(_ json: JSON, keyValue: String) {
        self.fromId = json["fromId"].string
        self.text = json["text"].string
        self.toId = json["toId"].string
        self.timestamp = json["timestamp"].int32Value
        self.imageUrl = json["imageUrl"].string
        self.videoUrl = json["videoUrl"].string
        self.messageId = keyValue
        self.imageWidth = json["imageWidth"].double ?? 0
        self.imageHeight = json["imageHeight"].double ?? 0
    }
    
    func chatPartnerId() -> String? {
        return fromId == Auth.auth().currentUser?.uid ? toId : fromId
    }
}
