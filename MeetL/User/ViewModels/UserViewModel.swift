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
    
    func load(){
        loadService.loadUser { [weak self] user in
            self?.loadedUser = user
            self?.imageFromUrl(completion: { image in
                guard let image = image else { return }
                self?.loadedImage = image
            })
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
