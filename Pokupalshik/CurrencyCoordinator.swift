//
//  CurrencyCoordinator.swift
//  Pokupalshik
//
//  Created by Roman Dmitrieivich on 11/29/16.
//  Copyright © 2016 Roman Dmitrieivich. All rights reserved.
//

import UIKit

protocol CurrencyCoordinatorDelegate {
    func didFinish(in coordinator: CurrencyCoordinator)
}

class CurrencyCoordinator: CoordinatorProtocol {
    
    var navigationController: UINavigationController?
    let cartVC: CartViewController
    var delegate: CurrencyCoordinatorDelegate?
    var currencyViewController: CurrencyTableViewController?
    
    init(cartVC: CartViewController) {
        guard let currencyTVC = UIStoryboard(name: "Main",
                                             bundle: Bundle.main).instantiateViewController(withIdentifier: "CurrencyTableViewController") as? CurrencyTableViewController else {
                                                fatalError()
        }
        self.currencyViewController = currencyTVC
        self.cartVC = cartVC
        self.navigationController = UINavigationController(rootViewController: currencyViewController!)
        currencyViewController?.delegate = self
    }
    
    func start() {
            cartVC.present(navigationController!, animated: true, completion: nil)
        
    }
    
    func finish() {
        navigationController?.presentingViewController?.dismiss(animated: true, completion: nil)
        currencyViewController = nil
        navigationController = nil
        delegate?.didFinish(in: self)
    }
}

extension CurrencyCoordinator: CurrencyTableViewControllerDelegate {
    func tapSave(in vc: CurrencyTableViewController) {
        vc.storage.removeAll()
        self.finish()
    }
}
