//
//  CoreDataService.swift
//  MeetL
//
//  Created by Александра Среднева on 24.02.24.
//

import Foundation
import CoreData

enum CoreDataEntities {
    case usersToMatch
    case personalAccount
}

class CoreDataService {
    
    let model = UserViewModel()
    
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
    
    func savePerson(personToSave: UserModel){

        let context = CoreDataService.shared.context
        let newUser = LikedPersonData(context: context)
        
        newUser.id = Int16(personToSave.id)
            newUser.name = personToSave.name
            newUser.age = Int16(personToSave.age)
            newUser.height = Int16(personToSave.height)
            newUser.weight = Int16(personToSave.weight)
            newUser.gender = personToSave.gender
            newUser.country = personToSave.country
            newUser.city = personToSave.city
            newUser.interests = personToSave.interestsString
            newUser.about = personToSave.about
            newUser.image = personToSave.image
            
            CoreDataService.shared.saveContext()
        }
    
    
    func saveAccountChanges(updatedInfo: UserModel){
        let context = CoreDataService.shared.context
        
        let fetchRequest: NSFetchRequest<PersonalPageData> = PersonalPageData.fetchRequest()
        if let existingAccount = try? context.fetch(fetchRequest).first {
            print(existingAccount)
            existingAccount.name = updatedInfo.name
            existingAccount.age = Int16(updatedInfo.age)
            existingAccount.height = Int16(updatedInfo.height)
            existingAccount.weight = Int16(updatedInfo.weight)
            existingAccount.gender = updatedInfo.gender
            existingAccount.country = updatedInfo.country
            existingAccount.city = updatedInfo.city
            existingAccount.interests = updatedInfo.interestsString
            existingAccount.about = updatedInfo.about
            existingAccount.image = updatedInfo.image
            
            CoreDataService.shared.saveContext()
        } else {

            let myAccount = PersonalPageData(context: context)
            myAccount.name = updatedInfo.name
            myAccount.age = Int16(updatedInfo.age)
            myAccount.height = Int16(updatedInfo.height)
            myAccount.weight = Int16(updatedInfo.weight)
            myAccount.gender = updatedInfo.gender
            myAccount.country = updatedInfo.country
            myAccount.city = updatedInfo.city
            myAccount.interests = updatedInfo.interestsString
            myAccount.about = updatedInfo.about
            myAccount.image = updatedInfo.image
            
            CoreDataService.shared.saveContext()
        }
    }

    
    func loadUsers() -> [UserModel] {
        
        var loadedPersons = [UserModel]()
        
        let context = CoreDataService.shared.context
        let fetchRequest: NSFetchRequest<LikedPersonData> = LikedPersonData.fetchRequest()
        
        do {
            let fetchedPersons = try context.fetch(fetchRequest)
            
            for person in fetchedPersons {
                let interestsString = person.interests ?? ""
                let interestsArray = interestsString.split(separator: ", ").map { String($0) }
                if let imageData = person.image {
                    let loadedPerson = UserModel(id: Int(person.id),
                                                     name: person.name ?? "",
                                                     age: Int(person.age),
                                                     height: Int(person.height),
                                                     weight: Int(person.weight),
                                                     interests: interestsArray ,
                                                     gender: person.gender ?? "",
                                                     city: person.city ?? "",
                                                     country: person.country ?? "",
                                                     about: person.about ?? "",
                                                     image: imageData)
                    loadedPersons.append(loadedPerson)
                }
            }
        } catch {
            print(error)
        }
        return loadedPersons
    }
    
    func loadAccountChanges() -> UserModel? {
            let context = CoreDataService.shared.context
            var fetchedInfo: PersonalPageData?

            let fetchRequest: NSFetchRequest<PersonalPageData> = PersonalPageData.fetchRequest()
            do {
                let fetchedPersons = try context.fetch(fetchRequest)
                if let fetchedPerson = fetchedPersons.first {
                    fetchedInfo = fetchedPerson
                }
                
            } catch {
                print(error)
            }
            
            guard let fetchedInfo = fetchedInfo else {return nil}
            
            let interestsString = fetchedInfo.interests ?? ""
            let interestsArray = interestsString.split(separator: ", ").map { String($0) }
            
            var fetchedImage = Data()
            if let image = fetchedInfo.image {
                fetchedImage = image
            }
            
            return UserModel(id: 0,
                                 name: fetchedInfo.name ?? "",
                                 age: Int(fetchedInfo.age),
                                 height: Int(fetchedInfo.height),
                                 weight: Int(fetchedInfo.weight),
                                 interests: interestsArray,
                                 gender: fetchedInfo.gender ?? "",
                                 city: fetchedInfo.city ?? "",
                                 country: fetchedInfo.country ?? "",
                                 about: fetchedInfo.about ?? "",
                                 image: fetchedImage)
        }
    
    func deletePerson(person: UserModel) {
        let context = CoreDataService.shared.context
        let fetchRequest: NSFetchRequest<LikedPersonData> = LikedPersonData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %d", person.id)
        
        do {
            let fetchedPersons = try context.fetch(fetchRequest)
            if let fetchedPerson = fetchedPersons.first {
                context.delete(fetchedPerson)
                CoreDataService.shared.saveContext()
            }
        } catch {
            print(error)
        }
    }
}
