//
//  UserLoadModel.swift
//  MeetL
//
//  Created by Александра Среднева on 19.02.24.
//

import UIKit

final class UserLoadService {
    
    private let userDefaultsKey = "currentIndex"
    private var index: Int {
        get {
            return UserDefaults.standard.integer(forKey: userDefaultsKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: userDefaultsKey)
        }
    }
    
    func loadUser(completion: @escaping (UserModel) -> ()) {
        let urlString = Constants.mainUrl
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            do {
                let userResponse = try JSONDecoder().decode([User].self, from: data)
                
                guard self.index < userResponse.count else {
                    self.index = 0
                    self.loadUser(completion: completion)
                    return
                }
                
                let user = userResponse[self.index]
                let posts = UserModel(id: user.id,
                                      name: user.name,
                                      age: user.age,
                                      height: user.height,
                                      weight: user.weight,
                                      interests: user.interests,
                                      gender: user.gender,
                                      city: user.city,
                                      country: user.country,
                                      about: user.about,
                                      image: Constants.imageUrl(responseGender: user.gender))
                self.index += 1
                completion(posts)
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
    
    func loadAllUsers(completion: @escaping ([UserModel]) -> Void) {
        
        let url = Constants.mainUrl
        guard let url = URL(string: url) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            
            do {
                let userResponse = try JSONDecoder().decode([User].self, from: data)
                
                let loadedArray = userResponse.map { user in
                    return UserModel(id: user.id,
                                     name: user.name,
                                     age: user.age,
                                     height: user.height,
                                     weight: user.weight,
                                     interests: user.interests,
                                     gender: user.gender,
                                     city: user.city,
                                     country: user.country,
                                     about: user.about,
                                     image: Constants.imageUrl(responseGender: user.gender))
                }
                completion(loadedArray)
            } catch {
                print(error)
            }
        }.resume()
    }

}
