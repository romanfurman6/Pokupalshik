//
//  Product.swift
//  Pokupalshik
//
//  Created by Roman Dmitrieivich on 11/9/16.
//  Copyright © 2016 Roman Dmitrieivich. All rights reserved.
//

import Foundation
import SQLite

struct Product: DatabaseManagable {
    
    static let service = DatabaseService<Product>()
    
    static var tableName = "products"
    
    var id: Int64 = 0
    var name: String
    var price: Double
    
    private struct Keys {
        static let id = "id"
        static let name = "name"
        static let price = "price"
    }
    
    
    
    init?(dict: [String:Any]) {
        guard
            let id = dict[Keys.id] as? Int64,
            let name = dict[Keys.name] as? String,
            let price = dict[Keys.price] as? Double
        else {
            return nil
        }
        self.id = id
        self.name = name
        self.price = price.roundTo(places: 2)
    }
    
    init(name: String, price: Double) {
        self.name = name
        self.price = price.roundTo(places: 2)
    }
    
    var fields: [String: Any] {
        return [Keys.name:self.name, Keys.price:self.price]
    }
    
    
}
