//
//  Friend+CoreDataProperties.swift
//  you
//
//  Created by Jun Zhou on 10/22/18.
//  Copyright © 2018 jzhou. All rights reserved.
//
//

import Foundation
import CoreData


extension Friend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest<Friend>(entityName: "Friend")
    }

    @NSManaged public var uid: String?
    @NSManaged public var profileImage: NSData?
    @NSManaged public var photoUrl: String?
    @NSManaged public var nickName: String?

}
