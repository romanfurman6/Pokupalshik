//
//  CartCoordinator.swift
//  Pokupalshik
//
//  Created by Roman Dmitrieivich on 11/29/16.
//  Copyright © 2016 Roman Dmitrieivich. All rights reserved.
//

import UIKit

class CartCoordinator: CoordinatorProtocol {
    
    let navigationController: UINavigationController
    var currencyCoordinator: CurrencyCoordinator?
    var productsCart: ProductsCart
    var purchaseHistory: PurchasesHistory?
    var cartViewController: CartViewController
    
    init(navigationController: UINavigationController, productsCart: ProductsCart) {
        self.navigationController = navigationController
        self.productsCart = productsCart
        guard let cartVC = UIStoryboard(name: "Main",
                                                 bundle: Bundle.main).instantiateViewController(withIdentifier: "CartViewController") as? CartViewController else {
                                                    fatalError()
        }
        self.cartViewController = cartVC
        
    }
    
    func start() {
        cartViewController.productsCart = productsCart
        cartViewController.purchasesHistory = purchaseHistory
        cartViewController.delegate = self
        navigationController.pushViewController(cartViewController, animated: true)
    }
    
    func finish() {
        purchaseHistory = nil
        navigationController.popViewController(animated: true)
    }
}

extension CartCoordinator: CartViewControllerDelegate {
    func tapAdd(in vc: CartViewController) {
        cartViewController.productsCart.clearCart()
        self.finish()
    }
    func tapPurchase(in vc: CartViewController) {
        cartViewController.productsCart.clearCart()
        self.finish()
    }
    
    func tapCurrency(in vc: CartViewController) {
        currencyCoordinator = CurrencyCoordinator(cartVC: vc)
        currencyCoordinator?.start()
    }
}







