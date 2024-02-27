//
//  UserLoadModel.swift
//  MeetL
//
//  Created by Александра Среднева on 19.02.24.
//

import UIKit

final class UserLoadService {
    
    func loadUser(completion: @escaping (UserModel) -> ()) {
        let urlString = Constants.mainUrl
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data else { return }
            
            do {
                let userResponse = try JSONDecoder().decode(User.self, from: data)
                let posts = UserModel(name: userResponse.name, 
                                      age: userResponse.age,
                                      job: userResponse.job,
                                      height: userResponse.height,
                                      weight: userResponse.weight,
                                      gender: userResponse.gender,
                                      religion: userResponse.religion,
                                      country: userResponse.address.country,
                                      city: userResponse.address.city,
                                      image: Constants.imageUrl(responseGender: userResponse.gender))
                completion(posts)
                print(posts.image)
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
}
