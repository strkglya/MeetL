//
//  User.swift
//  MeetL
//
//  Created by Александра Среднева on 20.02.24.
//

import Foundation

struct User: Codable {
    let id: Int
    let name: String
    let age: Int
    let height: Int
    let weight: Int
    let interests: [String]
    let gender: String
    let city: String
    let country: String
    let about: String
}

