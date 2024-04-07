//
//  TabBarController.swift
//  MeetL
//
//  Created by Александра Среднева on 21.03.24.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabBar()
    }

    
    private func setUpTabBar(){
        tabBar.tintColor = #colorLiteral(red: 0.8470588235, green: 0.0431372549, blue: 0.3803921569, alpha: 1)
        tabBar.backgroundColor = .white

        let chats = UIStoryboard(name: "Chats", bundle: nil).instantiateViewController(withIdentifier: "ChatsController") as! ChatsController
        let main = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
        let account = UIStoryboard(name: "PersonalPage", bundle: nil).instantiateViewController(withIdentifier: "PersonalPageController") as! PersonalPageController
        
        self.setViewControllers([main,chats,account], animated: true)
    
        main.tabBarItem.image = UIImage(named: "heart")
        main.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -30, right: 0)

        chats.tabBarItem.image = UIImage(named: "chat")
        chats.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -30, right: 0)

        account.tabBarItem.image = UIImage(named: "person")
        account.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -30, right: 0)

    }
}
