//
//  ChatsController.swift
//  MeetL
//
//  Created by Александра Среднева on 5.03.24.
//

import UIKit

class ChatsController: UIViewController {
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    let model = ChatsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        model.loadLikedUsers()
    }
    
    func bind(){
        model.userDidChange = { [weak self] in
            guard let self = self else {return}
            tableView.reloadData()
        }
    }
    
    @IBAction func toggleEditing(_ sender: Any) {
        model.isEditingEnabled.toggle()
        tableView.setEditing(model.isEditingEnabled, animated: true)
    }
}

extension ChatsController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

extension ChatsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return model.isEditingEnabled
    }
  
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if model.isEditingEnabled && editingStyle == .delete {
            //анимация где?
            model.delete(indexPath: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.likedUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "chatCell") as? ChatCell else { return UITableViewCell()}
        let user = model.likedUsers[indexPath.row]
        cell.configure(model: user)
        return cell
    }
}
