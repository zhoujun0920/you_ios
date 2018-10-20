//
//  User+CoreDataProperties.swift
//  you
//
//  Created by Jun Zhou on 10/19/18.
//  Copyright © 2018 jzhou. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var birthDate: NSDate?
    @NSManaged public var email: String?
    @NSManaged public var name: String?
    @NSManaged public var nickName: String?
    @NSManaged public var photoUrl: String?
    @NSManaged public var uid: String?
    @NSManaged public var profileImage: NSData?
}
