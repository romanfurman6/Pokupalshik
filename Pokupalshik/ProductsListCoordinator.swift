//
//  ProductsListCoordinator.swift
//  Pokupalshik
//
//  Created by Roman Dmitrieivich on 11/29/16.
//  Copyright © 2016 Roman Dmitrieivich. All rights reserved.
//

import UIKit

class ProductsListCoordinator: CoordinatorProtocol {
    
    let navigationController: UINavigationController
    let tabBarItem: UITabBarItem
    let cart = ProductsCart()
    var productListCollectionViewController: UIViewController?
    var cartCoordinator: CartCoordinator?
    
 init(navigationController: UINavigationController, tabBarItem: UITabBarItem) {
        self.navigationController = navigationController
        self.tabBarItem = tabBarItem
    }
    
    
    func start() {
        guard let productsListTVC = UIStoryboard(name: "Main",
                                            bundle: Bundle.main).instantiateViewController(withIdentifier: "ProductsCollectionViewController") as? ProductsCollectionViewController else {
                                                fatalError()
        }
        
        navigationController.pushViewController(productsListTVC, animated: true)
        productsListTVC.delegate = self
        productListCollectionViewController = productsListTVC
        productsListTVC.cart = cart
        
        
    }
    func finish() {}
    
    
}


extension ProductsListCoordinator: ProductsCollectionViewControllerDelegate {
    func didTapCart(in vc: ProductsCollectionViewController) {
        cartCoordinator = CartCoordinator(navigationController: navigationController, productsCart: cart)
        
        
        cartCoordinator?.start()
    }
    
}



