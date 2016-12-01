//
//  CartCoordinator.swift
//  Pokupalshik
//
//  Created by Roman Dmitrieivich on 11/29/16.
//  Copyright © 2016 Roman Dmitrieivich. All rights reserved.
//

import UIKit

protocol CartCoordinatorDelegate {
    func didFinish(in Coordinator: CartCoordinator)
}

class CartCoordinator: CoordinatorProtocol {
    
    var navigationController: UINavigationController
    var currencyCoordinator: CurrencyCoordinator?
    var delegate: CartCoordinatorDelegate?
    var productsCart: ProductsCart
    var purchaseHistory: PurchasesHistory?
    var cartViewController: CartViewController?
    var historyCoordinator: HistoryCoordinator?
    
    init(navigationController: UINavigationController, productsCart: ProductsCart) {
        self.navigationController = navigationController
        self.productsCart = productsCart
        self.cartViewController = StoryboardScene.Main.instantiateCartViewController()
        cartViewController?.delegate = self
        
    }
    
    func start() {
        cartViewController?.productsCart = productsCart
        cartViewController?.purchasesHistory = purchaseHistory
        navigationController.pushViewController(cartViewController!, animated: true)
    }
    
    func finish() {
        purchaseHistory = nil
        navigationController.popToRootViewController(animated: true)
        cartViewController = nil
        delegate?.didFinish(in: self)
    }
}

extension CartCoordinator: CartViewControllerDelegate {
    func tapAdd(in vc: CartViewController) {
        cartViewController?.productsCart.clearCart()
        self.finish()
        
    }
    
    func tapPurchase(in vc: CartViewController) {
        cartViewController?.productsCart.clearCart()
        self.finish()
    }
    
    func tapCurrency(in vc: CartViewController) {
        currencyCoordinator = CurrencyCoordinator(cartVC: vc)
        currencyCoordinator?.delegate = self
        currencyCoordinator?.start()
    }
    
    func tapBack(in vc: CartViewController) {
        self.finish()
    }
}

extension CartCoordinator: CurrencyCoordinatorDelegate {
    func didFinish(in: CurrencyCoordinator) {
        currencyCoordinator = nil
    }
}





