//
//  Purchase.swift
//  Pokupalshik
//
//  Created by Roman Dmitrieivich on 11/15/16.
//  Copyright © 2016 Roman Dmitrieivich. All rights reserved.
//

import Foundation

struct Package: DatabaseManagable {
    
    static let service = DatabaseService<Package>()
    
    static var tableName = "productsPurchases"
    
    var id: Int64 = 0
    var productCount: Int64
    var productId: Int64
    var purchaseId: Int64
    
    
    fileprivate struct Keys {
        static let productCount = "productCount"
        static let productId = "productId"
        static let purchaseId = "purchaseId"
    }
    
    init?(dict:[String:Any]) {
        
        guard
            let productCount = dict[Keys.productCount] as? Int64,
            let productId = dict[Keys.productId] as? Int64,
            let purchaseId = dict[Keys.purchaseId] as? Int64
            else {
                return nil
        }
        
        self.productCount = productCount
        self.productId = productId
        self.purchaseId = purchaseId
        
    }
    
    init(productCount: Int64, productId: Int64, purchaseId: Int64) {
        self.productCount = productCount
        self.productId = productId
        self.purchaseId = purchaseId
        
    }
    
    var fields: [String: Any] {
        return [Keys.productCount: self.productCount, Keys.productId: self.productId, Keys.purchaseId: self.purchaseId]
    }
    
}



