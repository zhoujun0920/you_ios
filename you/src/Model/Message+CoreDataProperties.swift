//
//  Message+CoreDataProperties.swift
//  you
//
//  Created by Jun Zhou on 10/22/18.
//  Copyright © 2018 jzhou. All rights reserved.
//
//

import Foundation
import CoreData


extension Message {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Message> {
        return NSFetchRequest<Message>(entityName: "Message")
    }
    @NSManaged public var messageId: String?
    @NSManaged public var fromId: String?
    @NSManaged public var text: String?
    @NSManaged public var timestamp: Int32
    @NSManaged public var toId: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var videoUrl: String?
    @NSManaged public var imageWidth: Double
    @NSManaged public var imageHeight: Double

}
