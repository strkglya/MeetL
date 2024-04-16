//
//  Constants.swift
//  MeetL
//
//  Created by Александра Среднева on 19.02.24.
//

import Foundation
import UIKit

final class Constants {
    
    static let mainUrl = "https://raw.githubusercontent.com/strkglya/jsonHolder/main/usersJson.json"
    
    static func imageUrl(responseGender: String) -> String {
        let randomNumber = Int.random(in: 0..<100)
        var gender = ""
        if responseGender == Genders.female.rawValue {
            gender = Genders.women.rawValue
        } else if responseGender == Genders.male.rawValue{
            gender = Genders.men.rawValue
        }
        return "https://randomuser.me/api/portraits/\(gender.lowercased())/\(randomNumber).jpg"
    }
    
    static func createAlert(alertTitle: String, alertMessage: String, actionTitle: String, alertStyle: UIAlertAction.Style) -> UIAlertController{
        let alert = UIAlertController(title: String(localized: String.LocalizationValue(alertTitle)), message: String(localized: String.LocalizationValue(alertMessage)), preferredStyle: .alert)
        let action = UIAlertAction(title: String(localized: String.LocalizationValue(actionTitle)) , style: alertStyle)
        alert.addAction(action)
        return alert
    }
}

enum Genders: String {
    case female = "Female"
    case male = "Male"
    case men = "Men"
    case women = "Women"
}

enum StoryboardIdentifier: String {
    case likedUsers = "ChatsController"
    case mainScreen = "ViewController"
    case personalPage = "PersonalPageController"
    case userDetails = "UserDetails"
    case filterPage = "FilterController"
}

enum StoryboardName: String {
    case likedUsers = "Chats"
    case mainScreen = "Main"
    case personalPage = "PersonalPage"
    case userDetails = "UserDetails"
    case filterPage = "FilterPage"
}

enum ImageNames: String {
    case heart
    case chat
    case person
    case pencil
    case checkmark
    case searchIcon
}

enum NibNames: String {
    case userCard = "UserCard"
    case chatCell = "chatCell"
}

enum Errors: String {
    case nibError = "Unable to convert nib"
    case simpleError = "Error"
}

enum AlertAttributes: String {
    case noMatches = "No matches found"
    case match = "It's a match!"
    case matchMessage = "It looks like this user liked you back!"
    case ok = "Ok"
}
