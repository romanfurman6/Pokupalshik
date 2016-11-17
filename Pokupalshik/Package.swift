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
    
    
    var id: Int64
    var productId: Int64
    var productCount: Int64
    
    
    
    
    fileprivate struct Keys {
        static let id = "id"
        static let productId = "productId"
        static let productCount = "productCount"
    }
    
    init?(dict:[String:Any]) {
        
        guard
            let id = dict[Keys.id] as? Int64,
            let productId = dict[Keys.productId] as? Int64,
            let productCount = dict[Keys.productCount] as? Int64

            else {
                return nil
        }
        
        self.id = id
        self.productId = productId
        self.productCount = productCount
        
    }
    
    init(id: Int64, productId: Int64, productCount: Int64) {
        self.id = id
        self.productId = productId
        self.productCount = productCount

        
    }
    
    var fields: [String: Any] {
        return [Keys.id: self.id, Keys.productId: self.productId, Keys.productCount: self.productCount]
    }
    
}



