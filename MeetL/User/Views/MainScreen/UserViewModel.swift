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
    var allUsersLoaded: (() ->Void)?
    var imageDidLoad: (() -> Void)?
        
    var loadedUser = UserFromJson(id: 0, name: "", age: 0, height: 0, weight: 0, interests: [], gender: "", city: "", country: "", about: "", image: ""){
        didSet {
            userDidChange?()
        }
    }
    
    var loadedUsers = [UserFromJson](){
        didSet {
            //print("Loaded users: \(loadedUsers)")
            allUsersLoaded?()
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
            self?.imageFromUrl { image in
                guard let image = image else {return}
                self?.loadedImage = image
            }
        }
    }
    
    func loadAllFromJson(){
        loadService.loadAllUsers(completion: {[weak self] loadedUsers in
            self?.loadedUsers = loadedUsers
        })
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
    
    var filteredUsers = [UserFromJson](){
        didSet {
            // print(filteredUsers)
        }
    }
    
    func saveToCoreData(likedPerson: UserFromJson, with image: UIImage){
        if let imageData = image.pngData() {
            CoreDataService.shared.savePerson(personToSave: UserModel(id: likedPerson.id,
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
}

extension UserViewModel: FilterDelegate {
    func didFinishSelectingFilters(filters: Filter) {
        let filteredUsers = loadedUsers.filter { user in
            let ageInRange = user.age >= filters.minAge && user.age <= filters.maxAge
            let heightInRange = user.height >= filters.minHeight && user.height <= filters.maxHeight
            let weightInRange = user.weight >= filters.minWeight && user.weight <= filters.maxWeight
            var interestsMatch = true
            if !filters.interests.isEmpty {
                interestsMatch = user.interests.contains(filters.interests)
            }
            return ageInRange && heightInRange && weightInRange && interestsMatch
        }
        print(filteredUsers)
        self.filteredUsers = filteredUsers
    }
}