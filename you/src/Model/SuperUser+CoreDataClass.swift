//
//  SuperUser+CoreDataClass.swift
//  you
//
//  Created by Jun Zhou on 10/22/18.
//  Copyright © 2018 jzhou. All rights reserved.
//
//

import Foundation
import CoreData
import SwiftyJSON

@objc(SuperUser)
public class SuperUser: NSManagedObject {
    func fromJSON(_ json: JSON) {
        self.nickName = json["nickName"].string
        self.uid = json["uid"].string
        self.role = json["role"].string
    }
}
