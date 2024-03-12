//
//  UserModel.swift
//  MeetL
//
//  Created by Александра Среднева on 20.02.24.
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
        var allInterests = ""
        for interest in interests {
            allInterests.append(interest)
        }
        return allInterests
    }
    
    let gender: String
    let city: String
    let country: String
    
    var address: String {
        return "\(country),\(city)"
    }
    
    let about: String

    let image: String
}
