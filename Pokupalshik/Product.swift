//
//  Product.swift
//  Pokupalshik
//
//  Created by Roman Dmitrieivich on 11/9/16.
//  Copyright © 2016 Roman Dmitrieivich. All rights reserved.
//

import Foundation
import SQLite

struct Product {
    static let service = DatabaseService<Product>()
    
    static var tableName = "products"
    
    var id: Int64 = 0
    var name: String
    var price: Double
    
    fileprivate struct Keys {
        static let id = "id"
        static let name = "name"
        static let price = "price"
    }
}

extension Product: DatabaseManagable {
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

extension Product: Equatable { }
func ==(lhs: Product, rhs: Product) -> Bool {
    return lhs.id == rhs.id
}

extension Product: Hashable {
    var hashValue: Int {
        return Int(id)
    }
}
