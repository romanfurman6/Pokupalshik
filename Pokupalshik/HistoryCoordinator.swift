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
    var historyTableViewController: UIViewController?
    
    init(navigationController: UINavigationController, tabBarItem: UITabBarItem) {
        self.navigationController = navigationController
        self.tabBarItem = tabBarItem
    }
    
    func start() {
        guard let historyTVC = UIStoryboard(name: "Main",
                                    bundle: Bundle.main).instantiateViewController(withIdentifier: "HistoryTableViewController") as? HistoryTableViewController else {
                                        fatalError()
        }
        
        navigationController.pushViewController(historyTVC, animated: true)
        historyTVC.delegate = self
        historyTableViewController = historyTVC
        historyTVC.productCart = cart
        historyTVC.purchasesHistory = purchasesHistory
    }
    
    func finish() {
    
    }
    
}

extension HistoryCoordinator: HistoryTableViewControllerDelegate {
    func didTapCart(in vc: HistoryTableViewController) {
        cartCoordinator = CartCoordinator(navigationController: navigationController, productsCart: cart)
        cartCoordinator?.purchaseHistory = purchasesHistory
        cartCoordinator?.start()
    }
}
