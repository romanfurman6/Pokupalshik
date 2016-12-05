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
    
    var storage = [Currency]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    let tapSave = PublishSubject<Void>()
    var currencyStorage = CurrencyStorage.shared
    
    @IBAction func dismiss(sender: AnyObject) {
        storage.removeAll()
        tapSave.onNext(())
    }
    func createAlertController() {
        let alert = UIAlertController(title: "Unable to connect to the server", message: "Please verify that your device can connect to the internet.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { action in self.getCurrencies()}))
        self.present(alert, animated: true, completion: nil)
    }
    
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrencies()
        title = "Currencies"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storage.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
        }
        let currency = storage[indexPath.row]
        CurrencyStorage.shared.currentCurrency = currency
    }
}


