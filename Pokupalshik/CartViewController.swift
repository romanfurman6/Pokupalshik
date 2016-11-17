//
//  CartViewController.swift
//  Pokupalshik
//
//  Created by Roman Dmitrieivich on 11/16/16.
//  Copyright © 2016 Roman Dmitrieivich. All rights reserved.
//

import UIKit

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var purchaseButton: UIButton!
    var purchasesHistory: PurchasesHistory?
    var productsCart: ProductsCart!
    let cartBarButton: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
    
    
    func createCartButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cartBarButton)
        cartBarButton.titleLabel?.text = "Currency"
        cartBarButton.addTarget(self, action: #selector(purchase), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if purchasesHistory != nil {
            purchaseButton.isEnabled = false
        }
        
        purchaseButton.addTarget(self, action: #selector(purchase),for: .touchUpInside)
        
        tableView.backgroundColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1)
        
        createCartButton()
    }
    
    
    func purchase() {
        //create new Purchase
        let newPurchase = Purchase(time: NSDate(), price: productsCart.totalProductsPrice)
        let newPurchaseID = Purchase.service.insert(object: newPurchase)
        print(Purchase.service.fetchObjects())
        //add products in Package
        for i in productsCart.products {
            _ = Package.service.insert(object: Package(id: newPurchaseID, productId: i.0.id, productCount: Int64(i.1)))
        }
        print(Package.service.fetchObjects())
        productsCart.clearCart()
        
        performSegue(withIdentifier: "historySegue", sender: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsCart.products.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartTableViewCell
        let product = productsCart.products[indexPath.row]
        
        cell.cartNameLabel.text = product.0.name
        cell.cartPriceLabel.text = String(Double(Double(product.0.price) * Double(product.1)))
        cell.cartProductImage.image = UIImage(named: "\(product.0.name)")
        cell.countOfProduct.text = String(product.1)
        
        //Fix
        cell.minusButton.addTarget(self, action: #selector(minusProductCount(_:)), for: .touchUpInside)
        
        //Fix
        cell.plusButton.addTarget(self, action: #selector(plusProductCount(_:)), for: .touchUpInside)
        
        return cell
    }
    
    //delete
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let product = productsCart.products[indexPath.row]
            productsCart.deleteAll(product: product.0)
            if purchasesHistory != nil {
                var editPurchase = (purchasesHistory?.editPurchase)!
                _ = Package.service.deleteTwoObject(withId: editPurchase.id, secondId: product.0.id)
                editPurchase.price = productsCart.totalProductsPrice
                print(productsCart.totalProductsPrice)
                _ = Purchase.service.update(object: editPurchase)
            }
            tableView.reloadData()
        }
    }

    
}

extension CartViewController {
    
    func updatePurchase(product: (Product,Int)) {
        if purchasesHistory != nil {
            
            let updateProduct = product
            var editPurchase = (purchasesHistory?.editPurchase)!
            Package.service.update(object: Package(id: editPurchase.id, productId: updateProduct.0.id, productCount: Int64(updateProduct.1)))
            editPurchase.price = productsCart.totalProductsPrice
            _ = Purchase.service.update(object: editPurchase)
        }
    }
    
    func minusProductCount(_ sender: AnyObject) {
        let button = sender as? UIButton
        let cell = button?.superview?.superview as? CartTableViewCell
        let indexPath = tableView.indexPath(for: cell!)
        var product = productsCart.products[(indexPath?.row)!]
        
        if Int((cell?.countOfProduct.text)!)! > 1 {
            
            productsCart.delete(product: product.0)
            cell?.countOfProduct.text = String(productsCart.products[(indexPath?.row)!].1)
            cell?.cartPriceLabel.text = String(productsCart.totalPriceOf(product: product.0))
        }
        
        product = productsCart.products[(indexPath?.row)!]
        updatePurchase(product: product)
    }
    
    func plusProductCount(_ sender: AnyObject) {
        let button = sender as? UIButton
        let cell = button?.superview?.superview as? CartTableViewCell
        let indexPath = tableView.indexPath(for: cell!)
        var product = productsCart.products[(indexPath?.row)!]
        
        productsCart.duplicate(product: product.0)
        
        cell?.countOfProduct.text = String(productsCart.products[(indexPath?.row)!].1)
        cell?.cartPriceLabel.text = String(productsCart.totalPriceOf(product: product.0))
        
        product = productsCart.products[(indexPath?.row)!]
        updatePurchase(product: product)
        
    }
    

}
