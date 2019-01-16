//
//  Friend+CoreDataClass.swift
//  you
//
//  Created by Jun Zhou on 10/22/18.
//  Copyright © 2018 jzhou. All rights reserved.
//
//

import Foundation
import CoreData
import SwiftyJSON

@objc(Friend)
public class Friend: NSManagedObject {
    func fromJSON(_ json: JSON) {
        self.nickName = json["nickName"].string
        self.uid = json["uid"].string
    }
}
