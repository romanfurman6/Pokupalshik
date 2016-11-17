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
    var productsCart: ProductsCart!
    let cartBarButton: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
    
    
    func createCartButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cartBarButton)
        cartBarButton.titleLabel?.text = "Currency"
        cartBarButton.addTarget(self, action: #selector(purchase), for: .touchUpInside)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        purchaseButton.addTarget(self, action: #selector(purchase),for: .touchUpInside)
        
        tableView.backgroundColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1)
        
        
        createCartButton()
    }
    
    
    func purchase() {
        //create new Purchase
        let newPurchase = Purchases(time: NSDate(), price: productsCart.totalProductsPrice)
        let newPurchaseID = Purchases.service.insert(object: newPurchase)
        print(Purchases.service.fetchObjects())
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
//        cell.minusButton.addTarget(self, action: #selector(minusProductCount(_:)), for: .touchUpInside)
        
        //Fix
//        cell.plusButton.addTarget(self, action: #selector(plusProductCount(_:)), for: .touchUpInside)
        
        return cell
    }

    
    //delete
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let product = productsCart.products[indexPath.row].0
            productsCart.deleteAll(product: product)
            tableView.reloadData()
        }
    }
    
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        if viewController === self {
            
        }
    }
    
    
}

extension CartViewController {
    
    
    //FIX!
    
    func minusProductCount(_ sender: AnyObject) {
        let button = sender as? UIButton
        let cell = button?.superview?.superview as? CartTableViewCell
        let indexPath = tableView.indexPath(for: cell!)
        let product = productsCart.products[(indexPath?.row)!]
        
        cell?.countOfProduct.text = Int((cell?.countOfProduct.text)!)! > 0 ? String(Int((cell?.countOfProduct.text)!)! - 1) : "0"
        cell?.cartPriceLabel.text = String(Double((cell?.cartPriceLabel.text)!)! - product.0.price)
        
        productsCart.deleteAt(product: productsCart.products[(indexPath?.row)!].0)
    }
    
    func plusProductCount(_ sender: AnyObject) {
        let button = sender as? UIButton
        let cell = button?.superview?.superview as? CartTableViewCell
        let indexPath = tableView.indexPath(for: cell!)
        let product = productsCart.products[(indexPath?.row)!]
        
        cell?.countOfProduct.text = String(Int((cell?.countOfProduct.text)!)! + 1)
        cell?.cartPriceLabel.text = String(Double((cell?.cartPriceLabel.text)!)! + product.0.price)
        
        productsCart.duplicate(product: productsCart.products[(indexPath?.row)!].0)
    }
    
    
    
}
