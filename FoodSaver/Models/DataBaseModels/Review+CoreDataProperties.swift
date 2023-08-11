//
//  Review+CoreDataProperties.swift
//  
//
//  Created on 06/11/22.
//
//

import Foundation
import CoreData


extension Review {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Review> {
        return NSFetchRequest<Review>(entityName: "Review")
    }

    @NSManaged public var comment: String?
    @NSManaged public var rating: Double
    @NSManaged public var food: Food?
    @NSManaged public var user: User?

}
