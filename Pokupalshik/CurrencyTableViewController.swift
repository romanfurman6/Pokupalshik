//
//  TableViewController.swift
//  Pokupalshik
//
//  Created by Roman Dmitrieivich on 11/20/16.
//  Copyright © 2016 Roman Dmitrieivich. All rights reserved.
//

import UIKit

class CurrencyTableViewController: UITableViewController {
    
    var storage: [Currency] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    let defaults = UserDefaults.standard
    var currencyStorage: CurrencyStorage!
    @IBAction func dismiss(sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    func getCurrency() {
        return APIManager.sharedAPI.getCurrency {
            (dictionary:[String: Double]?, error:NSError?) in
            for currency in dictionary! {
                self.storage.append(Currency(name: currency.key, coef: currency.value))
            }
            self.storage.insert(Currency(name: "USD", coef: 1), at: 0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrency()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storage.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currencyCell", for: indexPath) as! CurrencyTableViewCell
        
        cell.currecyNameLabel.text = storage[indexPath.row].name
        
        if let currentCurrency = CurrencyStorage.shared.currentCurrency {
            if currentCurrency.name == cell.currecyNameLabel.text {
                cell.accessoryType = .checkmark
                tableView.selectRow(at: indexPath, animated: false, scrollPosition: UITableViewScrollPosition.bottom)
            } else {
                cell.accessoryType = .none
            }
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
        defaults.set(currency.coef, forKey: "currentCurrencyCoef")
        defaults.set(currency.name, forKey: "currentCurrencyName")
    }
    
    
}
