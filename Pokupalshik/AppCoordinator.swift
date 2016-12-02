//
//  AppCoordinator.swift
//  Pokupalshik
//
//  Created by Roman Dmitrieivich on 11/29/16.
//  Copyright © 2016 Roman Dmitrieivich. All rights reserved.
//

import UIKit

class AppCoordinator: CoordinatorProtocol {
    
    private let window: UIWindow
    let tabBarController: UITabBarController
    var historyCoordinator: HistoryCoordinator?
    var productsListCoordinator: ProductsListCoordinator?
    
    
    init(window: UIWindow, tabBarController: UITabBarController) {
        self.window = window
        self.tabBarController = tabBarController
    }
    
    
    func start() {
        
        let productsNVC = UINavigationController()
        productsNVC.tabBarItem = UITabBarItem(title: "Products", image: nil, tag: 1)
        let historyNVC = UINavigationController()
        historyNVC.tabBarItem = UITabBarItem(title: "History", image: nil, tag: 2)
        
        productsListCoordinator = ProductsListCoordinator(navigationController: productsNVC, tabBarItem: productsNVC.tabBarItem)
        historyCoordinator = HistoryCoordinator(navigationController: historyNVC, tabBarItem: historyNVC.tabBarItem)
        
        tabBarController.viewControllers = [productsNVC, historyNVC]
        
        productsListCoordinator?.start()
        historyCoordinator?.start()

    }
    
    func finish() {
        
    }
}
