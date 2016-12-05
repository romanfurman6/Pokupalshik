//
//  ProductsListCoordinator.swift
//  Pokupalshik
//
//  Created by Roman Dmitrieivich on 11/29/16.
//  Copyright © 2016 Roman Dmitrieivich. All rights reserved.
//

import UIKit
import RxSwift


class ProductsListCoordinator: CoordinatorProtocol {
    
    let navigationController: UINavigationController
    let tabBarItem: UITabBarItem
    let cart = ProductsCart()
    var productListCollectionViewController: ProductsCollectionViewController?
    var cartCoordinator: CartCoordinator?
    let disposeBag = DisposeBag()
    
 init(navigationController: UINavigationController, tabBarItem: UITabBarItem) {
        self.navigationController = navigationController
        self.tabBarItem = tabBarItem
    }
    
    func start() {
        self.productListCollectionViewController = StoryboardScene.Main.instantiateProductsCollectionViewController()
        navigationController.pushViewController(productListCollectionViewController!, animated: true)
        
        productListCollectionViewController?.didTapCart
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.didTapCart()
            }).addDisposableTo(disposeBag)
        
        cartCoordinator?.didFinishCart
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.didFinish()
            }).addDisposableTo(disposeBag)
        
        productListCollectionViewController?.cart = cart
    }
    func finish() {}
}

extension ProductsListCoordinator {
    func didTapCart() {
        cartCoordinator = CartCoordinator(navigationController: navigationController, productsCart: cart)
        cartCoordinator?.navigationController = navigationController
        cartCoordinator?.productsCart = cart
        cartCoordinator?.start()
    }
    func didFinish() {
        cartCoordinator = nil
    }
}
