//
//  TableViewController.swift
//  Pokupalshik
//
//  Created by Roman Dmitrieivich on 11/20/16.
//  Copyright © 2016 Roman Dmitrieivich. All rights reserved.
//

import UIKit
import RxSwift

class CurrencyTableViewController: UITableViewController {
    
    var storage = Variable([Currency]())
        
    /*.value {
        didSet {
            self.tableView.reloadData()
        }
    }*/
    
    let tapSave = PublishSubject<Void>()
    var currencyStorage = CurrencyStorage.shared
    let disposeBag = DisposeBag()
    
    @IBAction func dismiss(sender: AnyObject) {
        storage.value.removeAll()
        tapSave.onNext(())
    }
    
    func createTable() {
        
//        storage.asObservable().bindTo(tableView.rx.base.dequeueReusableCell(withIdentifier: "cell"))
    }
    
    func createAlertController() {
        let alert = UIAlertController(title: "Unable to connect to the server", message: "Please verify that your device can connect to the internet.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { action in self.getCurrencies()}))
        self.present(alert, animated: true, completion: nil)
    }
    
    func getCurrencies() {
        return APIManager.shared.getCurrencies()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { currency in
                self.storage.value = currency
            }).addDisposableTo(disposeBag)
    }
    
    /*
    func getCurrencies() {
        return APIManager.shared.getCurrencies {
            (currency:[Currency]?, error: Error?) in
            if error == nil {
                for dict in currency! {
                    self.storage.append(dict)
                }
                self.storage.insert(Currency(name: "USD", coef: 1), at: 0)
            } else {
                self.createAlertController()
            }
        }
    }
    */
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCurrencies()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Currencies"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storage.value.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currencyCell", for: indexPath) as! CurrencyTableViewCell
        
        cell.currecyNameLabel.text = storage.value[indexPath.row].name
        
        if CurrencyStorage.shared.currentCurrency.name == cell.currecyNameLabel.text {
            cell.accessoryType = .checkmark
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: UITableViewScrollPosition.bottom)
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
        }
        print("Tap")
        let currency = storage.value[indexPath.row]
        CurrencyStorage.shared.currentCurrency = currency
    }
}


