//
//  SuperUser+CoreDataProperties.swift
//  you
//
//  Created by Jun Zhou on 10/22/18.
//  Copyright © 2018 jzhou. All rights reserved.
//
//

import Foundation
import CoreData


extension SuperUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SuperUser> {
        return NSFetchRequest<SuperUser>(entityName: "SuperUser")
    }

    @NSManaged public var uid: String?
    @NSManaged public var nickName: String?
    @NSManaged public var role: String?
    @NSManaged public var profileImage: NSData?

}
