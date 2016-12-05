//
//  HistoryCoordinator.swift
//  Pokupalshik
//
//  Created by Roman Dmitrieivich on 11/29/16.
//  Copyright © 2016 Roman Dmitrieivich. All rights reserved.
//

import UIKit
import RxSwift


class HistoryCoordinator: CoordinatorProtocol {
    
    let navigationController: UINavigationController
    let tabBarItem: UITabBarItem
    let cart = ProductsCart()
    var cartCoordinator: CartCoordinator?
    var purchasesHistory = PurchasesHistory()
    var historyTableViewController: HistoryTableViewController?
    let disposeBag = DisposeBag()
    
    init(navigationController: UINavigationController, tabBarItem: UITabBarItem) {
        self.navigationController = navigationController
        self.tabBarItem = tabBarItem
    }
    
    func start() {

        self.historyTableViewController = StoryboardScene.Main.instantiateHistoryTableViewController()
        navigationController.pushViewController(historyTableViewController!, animated: true)
        historyTableViewController?
            .didTapCart
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.didTapCart()
            }).addDisposableTo(disposeBag)
        cartCoordinator?
            .didFinishCart
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.didFinish()
            }).addDisposableTo(disposeBag)
        historyTableViewController?.productCart = cart
        historyTableViewController?.purchasesHistory = purchasesHistory
        
    }
    
    func finish() {}
}

extension HistoryCoordinator {
    func didTapCart() {
        cartCoordinator = CartCoordinator(navigationController: navigationController, productsCart: cart)
        cartCoordinator?.purchaseHistory = purchasesHistory
        cartCoordinator?.start()
    }
    func didFinish() {
        cartCoordinator = nil
    }
}

