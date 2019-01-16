//
//  User+CoreDataClass.swift
//  you
//
//  Created by Jun Zhou on 10/19/18.
//  Copyright © 2018 jzhou. All rights reserved.
//
//

import Foundation
import CoreData
import SwiftyJSON

@objc(User)
public class User: NSManagedObject {
    func fromJSON(_ json: JSON, keyValue: String) {
        self.name = json["fullName"].string
        self.nickName = json["nickName"].string
        self.email = json["emailAddress"].string
        let birthDate = json["birthDate"].int32Value
        self.birthDate = Date(timeIntervalSince1970: TimeInterval(birthDate)) as NSDate
        self.uid = keyValue
        self.photoUrl = json["photoUrl"].string
    }
}
