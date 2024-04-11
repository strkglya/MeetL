//
//  UserModel.swift
//  MeetL
//
//  Created by Александра Среднева on 20.02.24.
//

import Foundation

struct UserFromJson {
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
    let image: String
    
    var likedBack: Bool {
        return Bool.random()
    }
}
