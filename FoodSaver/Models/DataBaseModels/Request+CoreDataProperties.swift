//
//  Request+CoreDataProperties.swift
//  
//
//  Created on 08/11/22.
//
//

import Foundation
import CoreData


extension Request {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Request> {
        return NSFetchRequest<Request>(entityName: "Request")
    }

    @NSManaged public var date: Date?
    @NSManaged public var quantity: Int16
    @NSManaged public var status: Int16
    @NSManaged public var food: Food?
    @NSManaged public var requester: User?

}
