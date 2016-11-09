//
//  AppDelegate.swift
//  Pokupalshik
//
//  Created by Roman Dmitrieivich on 11/7/16.
//  Copyright © 2016 Roman Dmitrieivich. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow()
        self.window = window
        window.rootViewController = rootViewController()
        window.makeKeyAndVisible()
        
        return true
    }
    func rootViewController() -> UIViewController {
        let productTableVC = storyBoard.instantiateViewController(withIdentifier: "ProductsTableViewController") as! ProductsTableViewController
        let historyTableVC = storyBoard.instantiateViewController(withIdentifier: "HistoryTableViewController") as! HistoryTableViewController
        let tabBarController = UITabBarController()
        let navigationController = UINavigationController()
        navigationController.setViewControllers([productTableVC], animated: false)
        tabBarController.setViewControllers([navigationController,historyTableVC], animated: false)
        return tabBarController
    }
    
}

