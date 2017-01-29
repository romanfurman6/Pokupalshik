//
//  CartCoordinator.swift
//  Pokupalshik
//
//  Created by Roman Dmitrieivich on 11/29/16.
//  Copyright © 2016 Roman Dmitrieivich. All rights reserved.
//

import UIKit
import RxSwift

class CartCoordinator: CoordinatorProtocol {
    
    var navigationController: UINavigationController
    var currencyCoordinator: CurrencyCoordinator?
    let didFinishCart = PublishSubject<Void>()
    var productsCart: ProductsCart
    var purchaseHistory: PurchasesHistory?
    var cartViewController: CartViewController?
    var historyCoordinator: HistoryCoordinator?
    let disposeBag = DisposeBag()
    
    init(navigationController: UINavigationController, productsCart: ProductsCart) {
        self.navigationController = navigationController
        self.productsCart = productsCart
        self.cartViewController = StoryboardScene.Main.instantiateCartViewController()
    }
    
    func start() {
        cartViewController?.productsCart = productsCart
        cartViewController?.purchasesHistory = purchaseHistory
        navigationController.pushViewController(cartViewController!, animated: true)
        
        cartViewController?
            .didTapAdd
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.tapAdd()
            }).addDisposableTo(disposeBag)
        
        cartViewController?
            .didTapCurrency
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.tapCurrency()
            }).addDisposableTo(disposeBag)
        
        cartViewController?
            .didTapBack
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.tapBack()
            }).addDisposableTo(disposeBag)
        
        cartViewController?
            .didTapPurchase
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.tapPurchase()
            }).addDisposableTo(disposeBag)
        
        currencyCoordinator?
            .didFinish
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.didFinishCurrency()
            }).addDisposableTo(disposeBag)
    }
    
    func finish() {
        purchaseHistory = nil
        navigationController.popToRootViewController(animated: true)
        cartViewController = nil
        didFinishCart.onNext(())
    }
}

extension CartCoordinator {
    
    func tapAdd() {
        
        self.finish()
    }
    
    func tapPurchase() {
        
        self.finish()
    }
    
    func tapCurrency() {
        currencyCoordinator = CurrencyCoordinator(cartVC: self.cartViewController!)
        currencyCoordinator?.start()
    }
    
    func tapBack() {
        self.finish()
    }
    
    func didFinishCurrency() {
        currencyCoordinator = nil
    }
}





