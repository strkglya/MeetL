//
//  ChatsViewModel.swift
//  MeetL
//
//  Created by Александра Среднева on 2.04.24.
//

import Foundation
import UIKit

final class ChatsViewModel {
    
    private let chatOperator: ChatOperation
    
    init(chatOperator: ChatOperation) {
        self.chatOperator = chatOperator
    }
    
    var isEditingEnabled = false

    var userDidChange: (() -> Void)?

    var likedUsers = [UserModel]() {
        didSet {
            userDidChange?()
        }
    }
    private var likedPhoto = UIImage()
    
    func loadLikedUsers(){
        likedUsers = loadFromCoreData()
    }
    
    func deleteFromCoreData(person: UserModel){
        chatOperator.deletePerson(person: person)
    }
    
    func delete(indexPath: Int){
        deleteFromCoreData(person: likedUsers[indexPath])
        likedUsers.remove(at: indexPath)
    }
    
    func loadFromCoreData() -> [UserModel]{
        return chatOperator.loadUsers()
    }
}
