//
//  LikedPersonData+CoreDataProperties.swift
//  MeetL
//
//  Created by Александра Среднева on 14.03.24.
//
//

import Foundation
import CoreData


extension LikedPersonData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LikedPersonData> {
        return NSFetchRequest<LikedPersonData>(entityName: "LikedPersonData")
    }

    @NSManaged public var age: Int16
    @NSManaged public var city: String?
    @NSManaged public var country: String?
    @NSManaged public var gender: String?
    @NSManaged public var height: Int16
    @NSManaged public var image: String?
    @NSManaged public var name: String?
    @NSManaged public var weight: Int16
    @NSManaged public var id: Int16
    @NSManaged public var interests: String?
    @NSManaged public var about: String?

}

extension LikedPersonData : Identifiable {

}
