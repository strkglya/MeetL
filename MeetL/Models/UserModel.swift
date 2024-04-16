//
//  CoreDataModel.swift
//  MeetL
//
//  Created by Александра Среднева on 14.03.24.
//

import Foundation

struct UserModel {
    let id: Int
    let name: String
    let age: Int
    let height: Int
    let weight: Int
    let interests: [String]
    
    var interestsString: String {
        return interests.joined(separator: ", ")
    }
    
    let gender: String
    let city: String
    let country: String
    
    var address: String {
        return "\(country),\(city)"
    }
    
    let about: String
    let image: Data
    
    init(id: Int, name: String, age: Int, height: Int, weight: Int, interests: [String], gender: String, city: String, country: String, about: String, image: Data) {
        self.id = id
        self.name = name
        self.age = age
        self.height = height
        self.weight = weight
        self.interests = interests
        self.gender = gender
        self.city = city
        self.country = country
        self.about = about
        self.image = image
    }
}
