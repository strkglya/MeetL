//
//  TabBarController.swift
//  MeetL
//
//  Created by Александра Среднева on 21.03.24.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabBar()
    }

    
    private func setUpTabBar(){
        tabBar.tintColor = #colorLiteral(red: 0.8470588235, green: 0.0431372549, blue: 0.3803921569, alpha: 1)
        tabBar.backgroundColor = .white

        let chats = UIStoryboard(name: StoryboardName.likedUsers.rawValue, bundle: nil).instantiateViewController(withIdentifier: StoryboardIdentifier.likedUsers.rawValue) as! ChatsController
        let main = UIStoryboard(name: StoryboardName.mainScreen.rawValue, bundle: nil).instantiateViewController(withIdentifier: StoryboardIdentifier.mainScreen.rawValue) as! ViewController
        let account = UIStoryboard(name: StoryboardName.personalPage.rawValue, bundle: nil).instantiateViewController(withIdentifier: StoryboardIdentifier.personalPage.rawValue) as! PersonalPageController
        
        self.setViewControllers([main,chats,account], animated: true)
    
        main.tabBarItem.image = UIImage(named: ImageNames.heart.rawValue)
        main.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -30, right: 0)

        chats.tabBarItem.image = UIImage(named: ImageNames.chat.rawValue)
        chats.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -30, right: 0)

        account.tabBarItem.image = UIImage(named: ImageNames.person.rawValue)
        account.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -30, right: 0)

    }
}
