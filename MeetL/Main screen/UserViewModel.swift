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
    
    var loadedUser: UserFromJson? {
        didSet {
            self.imageFromUrl { [weak self] image in
                guard let image = image else {return}
                self?.loadedImage = image
            }
            userDidChange?()
        }
    }
    
    var loadedUsers = [UserFromJson]() {
        didSet {
            loadedUser = loadedUsers[safe: currentIndex]
            filteredUsers = loadedUsers
        }
    }
    
    var filteredUsers = [UserFromJson](){
        didSet {
            currentIndex = 0
            userDidChange?()
        }
    }
    
    var loadedImage = UIImage() {
        didSet {
            imageDidLoad?()
        }
    }
    
    var currentIndex = 0 {
        didSet {
            print(currentIndex)
            loadedUser = filteredUsers[safe: currentIndex]
        }
    }
    
    func loadAllFromJson(){
        loadService.loadAllUsers(completion: {[weak self] loadedUsers in
            self?.loadedUsers = loadedUsers
        })
    }
    
    func like(alertClosure: () ->()){
        currentIndex += 1
        guard let loadedUser = loadedUser else { return }
        if loadedUser.likedBack {
            alertClosure()
            saveToCoreData(likedPerson: loadedUser, with: loadedImage)
        }
    }
    
    func imageFromUrl(completion: @escaping (UIImage?) -> Void){
        guard let imageURLString = loadedUser?.image else {return}
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
            
            var genderMatch = true
            if !filters.preferedGender.isEmpty {
                genderMatch = filters.preferedGender.contains(user.gender)
            }
            let ageInRange = user.age >= filters.minAge && user.age <= filters.maxAge
            let heightInRange = user.height >= filters.minHeight && user.height <= filters.maxHeight
            let weightInRange = user.weight >= filters.minWeight && user.weight <= filters.maxWeight
            var interestsMatch = true
            if !filters.interests.isEmpty {
                interestsMatch = user.interests.contains(filters.interests)
            }
            return genderMatch && ageInRange && heightInRange && weightInRange && interestsMatch
        }
        print(filteredUsers)
        self.filteredUsers = filteredUsers
    }
}

extension Array {
  subscript(safe index: Index) -> Element? {
    0 <= index && index < count ? self[index] : nil
  }
}
