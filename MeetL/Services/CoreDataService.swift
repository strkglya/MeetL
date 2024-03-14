//
//  CoreDataService.swift
//  MeetL
//
//  Created by Александра Среднева on 24.02.24.
//

import Foundation
import CoreData

class CoreDataService {

    static let shared = CoreDataService()
    
    private init() {}
    
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MeetL")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    private func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    static func savePerson(personToSave: UserModel){
        
        let context = CoreDataService.shared.context
        let newUser = LikedPersonData(context: context)
        newUser.name = personToSave.name
        newUser.age = Int16(personToSave.age)
        newUser.height = Int16(personToSave.height)
        newUser.weight = Int16(personToSave.weight)
        newUser.gender = personToSave.gender
        newUser.country = personToSave.country
        newUser.city = personToSave.city
        newUser.interests = personToSave.interestsString
        newUser.image = personToSave.image
        CoreDataService.shared.saveContext()
    }
    
    static func loadUsers() -> [UserModel] {
        
        var loadedPersons = [UserModel]()
        
        let context = CoreDataService.shared.context
        let fetchRequest: NSFetchRequest<LikedPersonData> = LikedPersonData.fetchRequest()
        
        do {
            let fetchedPersons = try context.fetch(fetchRequest)
            
            for person in fetchedPersons {
                let loadedPerson = UserModel(id: Int(person.id),
                                             name: person.name ?? "",
                                             age: Int(person.age),
                                             height: Int(person.height),
                                             weight: Int(person.weight),
                                             interests: person.interests?.split(separator: ", ") as! [String] ,
                                             gender: person.gender ?? "",
                                             city: person.city ?? "",
                                             country: person.country ?? "",
                                             about: person.about ?? "",
                                             image: person.image ?? "")
                loadedPersons.append(loadedPerson)
            }
            
        } catch {
            print(error)
        }
        
        return loadedPersons
    }
}
