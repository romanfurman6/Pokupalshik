//
//  PurchaseHistory.swift
//  Pokupalshik
//
//  Created by Roman Dmitrieivich on 11/17/16.
//  Copyright © 2016 Roman Dmitrieivich. All rights reserved.
//

import Foundation


class PurchasesHistory {
    
    var arrOfPurchases = [Purchase]()
    
    var editPurchase: Purchase?
    
    func getPurchasePrice(index: Int64) -> Double{
        var price: Double = 0.0
        let productIdArr = Package.service.fetchProductBy(id: index)
        for i in productIdArr {
            let product = Product.service.fetchObjectBy(id: i.productId)
            price += (product?.price)! * Double(i.productCount)
        }
        return price
    }
    
    func delete(purchase: Purchase) {
        arrOfPurchases = arrOfPurchases.filter { $0 != purchase }
    }
    
}
