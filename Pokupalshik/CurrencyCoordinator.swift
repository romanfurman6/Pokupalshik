//
//  CurrencyCoordinator.swift
//  Pokupalshik
//
//  Created by Roman Dmitrieivich on 11/29/16.
//  Copyright © 2016 Roman Dmitrieivich. All rights reserved.
//

import UIKit
import RxSwift

class CurrencyCoordinator: CoordinatorProtocol {
    
    var navigationController: UINavigationController?
    let cartVC: CartViewController
    let didFinish = PublishSubject<Void>()
    var currencyViewController: CurrencyViewController?
    let disposeBag = DisposeBag()
    
    init(cartVC: CartViewController) {
        
        self.currencyViewController = StoryboardScene.Main.instantiateCurrencyViewController()
        self.cartVC = cartVC
        self.navigationController = UINavigationController(rootViewController: currencyViewController!)
        currencyViewController?
            .tapSave
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.tapSave()
            }).addDisposableTo(disposeBag)
    }
    
    func start() {
        cartVC.present(navigationController!, animated: true, completion: nil)
    }
    
    func finish() {
        navigationController?.presentingViewController?.dismiss(animated: true, completion: nil)
        currencyViewController = nil
        navigationController = nil
        didFinish.onNext(())
    }
}

extension CurrencyCoordinator {
    func tapSave() {
        self.finish()
    }
}
