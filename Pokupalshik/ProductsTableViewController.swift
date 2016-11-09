//
//  ProductsTableViewController.swift
//  Pokupalshik
//
//  Created by Roman Dmitrieivich on 11/7/16.
//  Copyright © 2016 Roman Dmitrieivich. All rights reserved.
//

import UIKit

class ProductsTableViewController: UITableViewController {
    
    
    var arrayOfProduct: [[AnyObject]] = []
    var product = Product()
    var purchases = Purchases()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(product.tableName)
        print(product.arr)
        print("==----==")
        print(purchases.tableName)
        print(purchases.arr)
        
//        arrayOfProduct =
//        database.insertObject(name: "Meat", price: 20)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productsCell", for: indexPath) as! ProductsTableViewCell
        
        cell.productNameLabel.text = String(describing: arrayOfProduct[indexPath.row][1])
        cell.productPriceLabel.text = String(describing: arrayOfProduct[indexPath.row][2])
        
        return cell
    }
}
