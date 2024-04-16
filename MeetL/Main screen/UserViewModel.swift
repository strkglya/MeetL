//
//  UserViewModel.swift
//  MeetL
//
//  Created by Александра Среднева on 19.02.24.
//

import UIKit

final class UserViewModel {
    
    private let loadService: LoadingService
    private let imageTransformer: ImageTransformer
    
    private let saver: PersonSaved
    
    init(loadService: LoadingService, imageTransformer: ImageTransformer, saver: PersonSaved) {
        self.loadService = loadService
        self.imageTransformer = imageTransformer
        self.saver = saver
    }
    
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
            loadedUser = filteredUsers[safe: currentIndex]
        }
    }
    
    func loadAllFromJson(){
        loadService.loadAllUsers(completion: {[weak self] loadedUsers in
            self?.loadedUsers = loadedUsers
        })
    }
    
    func like(alertClosure: () ->()){
        guard let loadedUser = loadedUser else { return }
        if loadedUser.likedBack {
            alertClosure()
            saveToCoreData(likedPerson: loadedUser, with: loadedImage)
        }
        currentIndex += 1
    }
    
    func imageFromUrl(completion: @escaping (UIImage?) -> Void){
        guard let urlString = loadedUser?.image else {return}
        imageTransformer.imageFromUrl(urlString: urlString) { [weak self] image in
            guard let image = image else {return}
            self?.loadedImage = image
        }
    }
        
    func saveToCoreData(likedPerson: UserFromJson, with image: UIImage){
        if let imageData = image.pngData() {

            saver.savePerson(personToSave: UserModel(id: likedPerson.id,
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
        self.filteredUsers = filteredUsers
    }
}

extension Array {
  subscript(safe index: Index) -> Element? {
    0 <= index && index < count ? self[index] : nil
  }
}
