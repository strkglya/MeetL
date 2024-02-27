//
//  User.swift
//  MeetL
//
//  Created by Александра Среднева on 20.02.24.
//

import Foundation

struct User: Decodable {
    let name: String
    let age: Int
    let job: String
    let height: Double
    let weight: Double
    let gender: String
    let religion: String
    let address: Address
    
    struct Address: Decodable {
        let city: String
        let country: String
    }
}

