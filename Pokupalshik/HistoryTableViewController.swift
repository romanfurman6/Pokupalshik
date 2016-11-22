//
//  HistoryTableViewController.swift
//  Pokupalshik
//
//  Created by Roman Dmitrieivich on 11/16/16.
//  Copyright © 2016 Roman Dmitrieivich. All rights reserved.
//

import UIKit

class HistoryTableViewController: UITableViewController {
    
    var purchasesHistory = PurchasesHistory()
    var productCart = ProductsCart()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        purchasesHistory.purchases = Purchase.service.fetchObjects()
        productCart.clearCart()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return purchasesHistory.purchases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as! HistoryTableViewCell
        
        let purchase = purchasesHistory.purchases[indexPath.row]
        
        cell.timeLabel.text = purchase.time.customFormatted
        cell.cartLabel.image = UIImage(named: "CartLogo")
        cell.priceLabel.text = String(purchasesHistory.getPrice(of: purchase).roundTo(places: 2))
        cell.currencyNameLabel.text = CurrencyStorage.shared.currentCurrency.name
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let purchase = purchasesHistory.purchases[indexPath.row]
        getProducts(purchase: purchase)
        purchasesHistory.editPurchase = purchase
        openPurchase()
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    

    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let purchase = purchasesHistory.purchases[indexPath.row]
            
            Purchase.service.deleteObject(withId: purchase.id)
            purchasesHistory.delete(purchase: purchase)
            Package.service.deleteObject(withId: purchase.id)

            tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "purchaseToCart" {
            let cartVC = segue.destination as! CartViewController
            cartVC.productsCart = productCart
            cartVC.purchasesHistory = purchasesHistory
            
        }
    }

}

extension HistoryTableViewController {
    
    func getProducts(purchase: Purchase) {
        let productsID = Package.service.fetchProducts(by: purchase)
        for i in productsID {
            for _ in 1...i.productCount {
                productCart.add(product: Product.service.fetchObjectBy(id: i.productId)!)
            }
        }
    }
    
    func openPurchase() {
        performSegue(withIdentifier: "purchaseToCart", sender: nil)
    }
}
