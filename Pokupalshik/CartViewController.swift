//
//  CartViewController.swift
//  Pokupalshik
//
//  Created by Roman Dmitrieivich on 11/16/16.
//  Copyright © 2016 Roman Dmitrieivich. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var purchaseButton: UIButton!
    var purchasesHistory: PurchasesHistory?
    var productsCart: ProductsCart!
    let currencyBarButton: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 35))

    
    func updatePurchaseButtonLabel() {
        purchaseButton.setTitle("Purchase" + " (\(productsCart.totalProductsPrice.roundTo(places: 2)))", for: .normal)
    }
    
    func purchase() {
        
        let newPurchase = Purchase(time: NSDate())
        let newPurchaseID = Purchase.service.insert(object: newPurchase)
        
        for i in productsCart.products {
            _ = Package.service.insert(object: Package(id: newPurchaseID, productId: i.0.id, productCount: Int64(i.1)))
        }
        productsCart.clearCart()
        
        _ = self.navigationController?.popViewController(animated: true)
        
    }
    
    func checkProductInPackage() ->  Bool {
        let editPurchaseId = purchasesHistory?.editPurchase?.id
        let object = Package.service.fetchObjectBy(id: editPurchaseId!)
        return object != nil ? true : false
    }
    
    func updatePurchase(product: (Product,Int)) {
        let updateProduct = product
        let editPurchase = (purchasesHistory?.editPurchase)!
        _ = Package.service.updatePurchase(package: Package(id: editPurchase.id, productId: updateProduct.0.id, productCount: Int64(updateProduct.1)), purchaseId: editPurchase.id, productId: updateProduct.0.id)
    }
    
    
    func minusProductCount(_ sender: AnyObject) {
        let button = sender as? UIButton
        let cell = button?.superview?.superview as? CartTableViewCell
        let indexPath = tableView.indexPath(for: cell!)
        var product = productsCart.products[(indexPath?.row)!]
        
        if product.1 > 1 {
            
            productsCart.delete(product: product.0)
            cell?.countOfProduct.text = String(productsCart.getCountOf(product: product.0))
            cell?.cartPriceLabel.text = String((productsCart.totalPriceOf(product: product.0)).roundTo(places: 2))
            updatePurchaseButtonLabel()
            
            if purchasesHistory != nil {
                product = productsCart.products[(indexPath?.row)!]
                updatePurchase(product: product)
            }
            
        }
    }
    
    func plusProductCount(_ sender: AnyObject) {
        let button = sender as? UIButton
        let cell = button?.superview?.superview as? CartTableViewCell
        let indexPath = tableView.indexPath(for: cell!)
        var product = productsCart.products[(indexPath?.row)!]
        
        productsCart.duplicate(product: product.0)
        cell?.countOfProduct.text = String(productsCart.getCountOf(product: product.0))
        cell?.cartPriceLabel.text = String((productsCart.totalPriceOf(product: product.0)).roundTo(places: 2))
        updatePurchaseButtonLabel()
        
        if purchasesHistory != nil {
            product = productsCart.products[(indexPath?.row)!]
            updatePurchase(product: product)
        }
    }
    
    func createCurrencyButton() {
        currencyBarButton.setImage(UIImage(named: "Currency"), for: .normal)
        currencyBarButton.addTarget(self, action: #selector(chooseCurrency), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: currencyBarButton)
    }
    
    func chooseCurrency() {
        performSegue(withIdentifier: "chooseCurrency", sender: nil)
    }
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsCart.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartTableViewCell
        let product = productsCart.products[indexPath.row]
        
        cell.cartNameLabel.text = product.0.name
        cell.cartProductImage.image = UIImage(named: "\(product.0.name)")
        cell.countOfProduct.text = String(product.1)
        
        
        cell.currencyNameLabel.text = CurrencyStorage.shared.currentCurrency.name
        cell.cartPriceLabel.text = String(productsCart.totalPriceOf(product: product.0).roundTo(places: 2))
        
        cell.minusButton.addTarget(self, action: #selector(minusProductCount(_:)), for: .touchUpInside)
        
        cell.plusButton.addTarget(self, action: #selector(plusProductCount(_:)), for: .touchUpInside)
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        updatePurchaseButtonLabel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updatePurchaseButtonLabel()
        
        if purchasesHistory != nil {
            purchaseButton.isEnabled = false
        }
        
        purchaseButton.addTarget(self, action: #selector(purchase), for: .touchUpInside)
        
        tableView.backgroundColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1)
        
        createCurrencyButton()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let product = productsCart.products[indexPath.row]
            productsCart.deleteAll(product: product.0)
            
            if purchasesHistory != nil {
                
                let editPurchase = (purchasesHistory?.editPurchase)!
                _ = Package.service.deleteProduct(purchaseId: editPurchase.id, productId: product.0.id)
                
                if !checkProductInPackage() {
                    _ = Purchase.service.deleteObject(withId: editPurchase.id)
                } else {
                    _ = Purchase.service.update(object: editPurchase)
                }
                
            }
            updatePurchaseButtonLabel()
            tableView.reloadData()
        }
    }
}
