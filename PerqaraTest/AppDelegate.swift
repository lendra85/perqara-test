//
//  AppDelegate.swift
//  PerqaraTest
//
//  Created by Sailendra Salsabil on 15/08/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        let navVC = UINavigationController(rootViewController: MainVC())
        navVC.navigationBar.isHidden = true
        navVC.view.backgroundColor = .white
        self.window?.rootViewController = navVC
        self.window?.makeKeyAndVisible()
        return true
    }


}
