//
//  PurchaseHistory.swift
//  Pokupalshik
//
//  Created by Roman Dmitrieivich on 11/17/16.
//  Copyright © 2016 Roman Dmitrieivich. All rights reserved.
//

import Foundation


class PurchasesHistory {
    
    var arrOfPurchases = [Purchases]()
    
    func delete(purchase: Purchases) {
        arrOfPurchases = arrOfPurchases.filter { $0 != purchase }
    }
    
}
