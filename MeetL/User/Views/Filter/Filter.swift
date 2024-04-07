//
//  Filter.swift
//  MeetL
//
//  Created by Александра Среднева on 6.04.24.
//

import Foundation

struct Filter {
    let preferedGender: [String]
    let minAge: Int
    let maxAge: Int
    let minHeight: Int
    let maxHeight: Int
    let minWeight: Int
    let maxWeight: Int
    let interests: [String]
    
    init() {
        self.minAge = 0
        self.maxAge = 0
        self.minHeight = 0
        self.maxHeight = 0
        self.minWeight = 0
        self.maxWeight = 0
        self.interests = []
        self.preferedGender = []
    }
    
    init(gender: [String], minAge: Int, maxAge: Int, minHeight: Int, maxHeight: Int, minWeight: Int, maxWeight: Int, interests: [String]) {
        self.preferedGender = gender
        self.minAge = minAge
        self.maxAge = maxAge
        self.minHeight = minHeight
        self.maxHeight = maxHeight
        self.minWeight = minWeight
        self.maxWeight = maxWeight
        self.interests = interests
    }
}
