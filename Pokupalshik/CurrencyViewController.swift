//
//  CurrencyViewController.swift
//  Pokupalshik
//
//  Created by Roman Dmitrieivich on 12/6/16.
//  Copyright © 2016 Roman Dmitrieivich. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CurrencyViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func dismiss(sender: AnyObject) {
        storage.removeAll()
        print(storage)
        tapSave.onNext(())
    }
    
    var storage = Variable([Currency]()).value {
        didSet {
            tableView.reloadData()
        }
    }
    
    let tapSave = PublishSubject<Void>()
    var currencyStorage = CurrencyStorage.shared
    let disposeBag = DisposeBag()
    
    func getCurrencies() {
//        storage.asDriver().drive({})
//        storage.asDriver().map({_ in ()}).drive({ _ in self.tableView.reloadData() })
        APIManager.shared.getCurrencies()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { currency in
                self.storage = currency
            }, onError: { _ in
                self.createAlertController()
            }, onCompleted: nil, onDisposed: nil)
            .addDisposableTo(disposeBag)
        
//        APIManager.shared.getCurrencies()
//            .observeOn(MainScheduler.instance)
//            .subscribe(onNext: { currency in
//                
//                self.storage = currency
//        }).addDisposableTo(disposeBag)
    }

    func createAlertController() {
        let alert = UIAlertController(title: "Unable to connect to the server", message: "Please verify that your device can connect to the internet.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { action in self.getCurrencies()}))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCurrencies()
        print("viewwill\(storage)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Currencies"
    }
}
extension CurrencyViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currencyCell", for: indexPath) as! CurrencyTableViewCell
        
        cell.currecyNameLabel.text = storage[indexPath.row].name
        
        if CurrencyStorage.shared.currentCurrency.name == cell.currecyNameLabel.text {
            cell.accessoryType = .checkmark
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: UITableViewScrollPosition.bottom)
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
        }
        let currency = storage[indexPath.row]
        CurrencyStorage.shared.currentCurrency = currency
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
}
