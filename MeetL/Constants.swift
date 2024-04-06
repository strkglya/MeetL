//
//  Constants.swift
//  MeetL
//
//  Created by Александра Среднева on 19.02.24.
//

import Foundation
import UIKit

final class Constants {
//    let gender: Gender
    static let mainUrl = "https://raw.githubusercontent.com/strkglya/jsonHolder/main/usersJson.json"
    
    static func imageUrl(responseGender: String) -> String {
        let randomNumber = Int.random(in: 0..<100)
        var gender = ""
        if responseGender == "Female"{
            gender = "women"
        } else if responseGender == "Male"{
            gender = "men"
        }
        return "https://randomuser.me/api/portraits/\(gender.lowercased())/\(randomNumber).jpg"
        }
    
    static func createAlert(alertTitle: String, alertMessage: String, actionTitle: String, alertStyle: UIAlertAction.Style) -> UIAlertController{
        let alert = UIAlertController(title: "Error!", message: "All fields must be filled. Fill them or otherwise your changes won't be saved ", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: alertStyle)
        alert.addAction(action)
        return alert
    }
}
