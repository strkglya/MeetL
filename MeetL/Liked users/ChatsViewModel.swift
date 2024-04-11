//
//  ChatsViewModel.swift
//  MeetL
//
//  Created by Александра Среднева on 2.04.24.
//

import Foundation
import UIKit

class ChatsViewModel {
    
    var isEditingEnabled = false

    var userDidChange: (() -> Void)?

    var likedUsers = [UserModel]() {
        didSet {
            userDidChange?()
        }
    }
    var likedPhoto = UIImage()
    
    func loadLikedUsers(){
        likedUsers = loadFromCoreData()
    }
    
    func deleteFromCoreData(person: UserModel){
        CoreDataService.shared.deletePerson(person: person)
    }
    
    func delete(indexPath: Int){
        deleteFromCoreData(person: likedUsers[indexPath])
        likedUsers.remove(at: indexPath)
    }
    
    func loadFromCoreData() -> [UserModel]{
        return CoreDataService.shared.loadUsers()
    }
}
