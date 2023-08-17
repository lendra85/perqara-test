//
//  MainVC.swift
//  PerqaraTest
//
//  Created by Sailendra Salsabil on 15/08/23.
//

import UIKit

class MainVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let homeVC = HomeVC()
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        let favoriteVC = FavoriteVC()
        favoriteVC.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(systemName: "heart"), tag: 1)
        viewControllers = [homeVC, favoriteVC]
        tabBar.isTranslucent = false
        tabBar.backgroundColor = .systemGray6
        tabBar.tintColor = .systemIndigo
    }
}
