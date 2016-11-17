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
        purchasesHistory.arrOfPurchases = Purchase.service.fetchObjects()
        productCart.clearCart()
        tableView.reloadData()
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        purchasesHistory.arrOfPurchases = Purchase.service.fetchObjects()
        /*
        print("purchasesHistory.array:\(purchasesHistory.arrOfPurchases)")
        print("Purchases.fetch:\(Purchases.service.fetchObjects())")
        print("Package.fetch:\(Package.service.fetchObjects())")
        */
    }
    
    
    func getProducts(index: Int64) {
        let productsID = Package.service.fetchObjectsBy(id: index)
        for i in productsID {
            for _ in 1...i.productCount {
                productCart.add(product: Product.service.fetchObjectBy(id: i.productId)!)
            }
        }
    }
    
    
    func openPurchase() {
        performSegue(withIdentifier: "purchaseToCart", sender: nil)
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return purchasesHistory.arrOfPurchases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as! HistoryTableViewCell
        
        let purchase = purchasesHistory.arrOfPurchases[indexPath.row]
        
        cell.timeLabel.text = (purchase.time).customFormatted
        cell.cartLabel.image = UIImage(named: "Cart")
        cell.priceLabel.text = String(purchase.price)
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let purchase = purchasesHistory.arrOfPurchases[indexPath.row]
        getProducts(index: purchase.id)
        purchasesHistory.editPurchase = purchase
        openPurchase()
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    

    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let purchase = purchasesHistory.arrOfPurchases[indexPath.row]
            
            
            Purchase.service.deleteObject(withId: purchase.id)
            purchasesHistory.delete(purchase: purchase)
            Package.service.deleteObject(withId: purchase.id)
            /*
            print("purchasesHistory.array:\(purchasesHistory.arrOfPurchases)")
            print("Purchases.fetch:\(Purchase.service.fetchObjects())")
            print("Package.fetch:\(Package.service.fetchObjects())")
            */
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
