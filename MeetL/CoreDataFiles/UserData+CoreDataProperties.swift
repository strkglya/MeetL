//
//  UserData+CoreDataProperties.swift
//  MeetL
//
//  Created by Александра Среднева on 24.02.24.
//
//

import Foundation
import CoreData


extension UserData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserData> {
        return NSFetchRequest<UserData>(entityName: "UserData")
    }

    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var job: String?
    @NSManaged public var height: Double
    @NSManaged public var weight: Double
    @NSManaged public var gender: String?
    @NSManaged public var religion: String?
    @NSManaged public var country: String?
    @NSManaged public var city: String?
    @NSManaged public var image: String?

}

extension UserData : Identifiable {

}
