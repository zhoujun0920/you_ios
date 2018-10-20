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
        self.name = json["name"].stringValue
        self.nickName = json["nickName"].stringValue
        self.email = json["emailAddress"].stringValue
        let birthDate = json["birthDate"].doubleValue
        self.birthDate = Date(timeIntervalSince1970: birthDate) as NSDate
        self.uid = keyValue
        self.photoUrl = json["photoUrl"].stringValue
    }
}
