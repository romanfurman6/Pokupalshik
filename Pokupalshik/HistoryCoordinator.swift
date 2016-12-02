//
//  HistoryCoordinator.swift
//  Pokupalshik
//
//  Created by Roman Dmitrieivich on 11/29/16.
//  Copyright © 2016 Roman Dmitrieivich. All rights reserved.
//

import UIKit


class HistoryCoordinator: CoordinatorProtocol {
    
    let navigationController: UINavigationController
    let tabBarItem: UITabBarItem
    let cart = ProductsCart()
    var cartCoordinator: CartCoordinator?
    var purchasesHistory = PurchasesHistory()
    var historyTableViewController: HistoryTableViewController?
    
    init(navigationController: UINavigationController, tabBarItem: UITabBarItem) {
        self.navigationController = navigationController
        self.tabBarItem = tabBarItem
    }
    
    func start() {

        self.historyTableViewController = StoryboardScene.Main.instantiateHistoryTableViewController()
        navigationController.pushViewController(historyTableViewController!, animated: true)
        historyTableViewController?.delegate = self
        historyTableViewController?.productCart = cart
        historyTableViewController?.purchasesHistory = purchasesHistory
        
    }
    
    func finish() {}
}

extension HistoryCoordinator: HistoryTableViewControllerDelegate {
    func didTapCart(in vc: HistoryTableViewController) {
        cartCoordinator = CartCoordinator(navigationController: navigationController, productsCart: cart)
        cartCoordinator?.delegate = self
        cartCoordinator?.purchaseHistory = purchasesHistory
        cartCoordinator?.start()
    }
}

extension HistoryCoordinator: CartCoordinatorDelegate {
    func didFinish(in: CartCoordinator) {
        cartCoordinator = nil
    }
}
