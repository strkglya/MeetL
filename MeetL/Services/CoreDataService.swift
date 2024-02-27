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
    
    private func saveUser(user: UserModel){
        let context = CoreDataService.shared.context
        let newUser = UserData(context: context)
        newUser.name = user.name
        newUser.age = Int16(user.age)
        newUser.job = user.job
        newUser.height = user.height
        newUser.weight = user.weight
        newUser.gender = user.gender
        newUser.religion = user.religion
        newUser.country = user.country
        newUser.city = user.city
        newUser.image = user.image
        CoreDataService.shared.saveContext()
    }
}
