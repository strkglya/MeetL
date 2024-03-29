//
//  UserViewModel.swift
//  MeetL
//
//  Created by Александра Среднева on 19.02.24.
//

import UIKit

final class UserViewModel {
    
    private let loadService = UserLoadService()
    
    var userDidChange: (() -> Void)?
    var imageDidLoad: (() -> Void)?
    
    var loadedUser = UserModel(id: 0, name: "", age: 0, height: 0, weight: 0, interests: [], gender: "", city: "", country: "", about: "", image: ""){
        didSet {
            userDidChange?()
        }
    }
    
    var loadedImage = UIImage() {
        didSet {
            imageDidLoad?()
        }
    }
    
    func loadFromJson(){
        loadService.loadUser { [weak self] user in
            self?.loadedUser = user
            let image = UIImage()
            self?.imageFromUrl { image in
                guard let image = image else {return}
                self?.loadedImage = image
            }
        }
    }
    
    func imageFromUrl(completion: @escaping (UIImage?) -> Void){
           let imageURLString = loadedUser.image
           guard let imageURL = URL(string: imageURLString) else { return }
           
           URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
               guard error == nil, let data = data, let image = UIImage(data: data) else {
                   print("Error loading image: \(error?.localizedDescription ?? "Unknown error")")
                   completion(nil)
                   return
               }
               completion(image)
           }.resume()
       }
    
    func saveToCoreData(likedPerson: UserModel, with image: UIImage){
        if let imageData = image.pngData() {
            CoreDataService.shared.savePerson(personToSave: CoreDataModel(id: likedPerson.id,
                                                                          name: likedPerson.name,
                                                                          age: likedPerson.age,
                                                                          height: likedPerson.height,
                                                                          weight: likedPerson.weight,
                                                                          interests: likedPerson.interests,
                                                                          gender: likedPerson.gender,
                                                                          city: likedPerson.city,
                                                                          country: likedPerson.country,
                                                                          about: likedPerson.about,
                                                                          image: imageData))
        }
        
    }
    
    func loadFromCoreData() -> [CoreDataModel]{
        return CoreDataService.shared.loadUsers()
    }
    
    func saveAccountChangesToCoreData(user: CoreDataModel){
            CoreDataService.shared.saveAccountChanges(updatedInfo: CoreDataModel(id: user.id,
                                                                                 name: user.name,
                                                                                 age: user.age,
                                                                                 height: user.height,
                                                                                 weight: user.weight,
                                                                                 interests: user.interests,
                                                                                 gender: user.gender,
                                                                                 city: user.city,
                                                                                 country: user.country,
                                                                                 about: user.about,
                                                                                 image: user.image))
    }
    func loadAccountChangesFromCoreData() -> CoreDataModel{
        CoreDataService.shared.loadAccountChanges()
    }
}
