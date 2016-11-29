//
//  CurrencyCoordinator.swift
//  Pokupalshik
//
//  Created by Roman Dmitrieivich on 11/29/16.
//  Copyright © 2016 Roman Dmitrieivich. All rights reserved.
//

import UIKit

class CurrencyCoordinator: CoordinatorProtocol {
    
    let navigationController: UINavigationController
    let cartVC: CartViewController
    var currencyViewController: CurrencyTableViewController?
    
    init(cartVC: CartViewController) {
        guard let currencyTVC = UIStoryboard(name: "Main",
                                             bundle: Bundle.main).instantiateViewController(withIdentifier: "CurrencyTableViewController") as? CurrencyTableViewController else {
                                                fatalError()
        }
        self.currencyViewController = currencyTVC
        self.cartVC = cartVC
        let navController = UINavigationController(rootViewController: currencyViewController!)
        
        self.navigationController = navController
    }
    
    func start() {
            cartVC.present(navigationController, animated: true, completion: nil)
        currencyViewController?.delegate = self
    }
    
    func finish() {
        navigationController.presentingViewController?.dismiss(animated: true, completion: nil)
        currencyViewController = nil
    }
}

extension CurrencyCoordinator: CurrencyTableViewControllerDelegate {
    func tapSave(in vc: CurrencyTableViewController) {
        vc.storage.removeAll()
        self.finish()
    }
}
