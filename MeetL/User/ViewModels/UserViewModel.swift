//
//  UserViewModel.swift
//  MeetL
//
//  Created by Александра Среднева on 19.02.24.
//

import UIKit

final class UserViewModel {
    
    private let loadService = UserLoadService()
    
    var loadedUser = UserModel(name: "", age: 0, job: "", height: 0, weight: 0, gender: "", religion: "", country: "", city: "", image: ""){
        didSet {
            userDidChange?()
        }
    }
    
    var userDidChange: (() -> Void)?
    
    func load(){
        loadService.loadUser { [weak self] user in
            self?.loadedUser = user
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
}