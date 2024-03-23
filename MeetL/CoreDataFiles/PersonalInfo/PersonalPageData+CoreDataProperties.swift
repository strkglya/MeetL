//
//  PersonalPageData+CoreDataProperties.swift
//  MeetL
//
//  Created by Александра Среднева on 22.03.24.
//
//

import Foundation
import CoreData


extension PersonalPageData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersonalPageData> {
        return NSFetchRequest<PersonalPageData>(entityName: "PersonalPageData")
    }

    @NSManaged public var about: String?
    @NSManaged public var age: Int16
    @NSManaged public var city: String?
    @NSManaged public var country: String?
    @NSManaged public var gender: String?
    @NSManaged public var height: Int16
    @NSManaged public var image: Data?
    @NSManaged public var interests: String?
    @NSManaged public var name: String?
    @NSManaged public var weight: Int16

}

extension PersonalPageData : Identifiable {

}
