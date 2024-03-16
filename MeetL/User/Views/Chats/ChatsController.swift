//
//  ChatsController.swift
//  MeetL
//
//  Created by Александра Среднева on 5.03.24.
//

import UIKit

class ChatsController: UIViewController {

    let model = UserViewModel()
    
    var likedUsers = [CoreDataModel]()
    var likedPhoto = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        likedUsers = model.loadFromCoreData()
    }
}

extension ChatsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

extension ChatsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return likedUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "chatCell") as? ChatCell else { return UITableViewCell()}
        cell.configure(model: likedUsers[indexPath.row])
        return cell
    }
}
