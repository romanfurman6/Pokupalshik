//
//  PackageDataService.swift
//  Pokupalshik
//
//  Created by Roman Dmitrieivich on 11/18/16.
//  Copyright © 2016 Roman Dmitrieivich. All rights reserved.
//

import Foundation

class PackageDataService: DatabaseService<Package> {
    
    func deleteProduct(purchaseId: Int64, productId: Int64) {
        let query = "DELETE FROM productsPurchases WHERE id = \(purchaseId) AND productId = \(productId)"
        try! self.service.execute(query)
    }
    
    func fetchProductBy(id: Int64) -> [Package] {
        guard let result = try? service.prepare("SELECT * FROM productsPurchases WHERE id = \(id)") else {
            fatalError()
        }
        let z: [Package] = result.map { row -> [String : Any] in
            
            var dict = [String: Any]()
            row
                .enumerated()
                .forEach { (index, item) in
                    dict[result.columnNames[index]] = item
            }
            
            return dict
            }.flatMap { Package(dict: $0) }
        
        return z
    }
    
    func updatePurchase(package: Package, purchaseId: Int64, productId: Int64) {
        let array = package.fields.map { $0 }
        let columns = array.map { $0.0 }.map { "\"\($0)\"" } as [String]
        
        let newValues = array
            .map { $0.1 }
            .map { value -> String in
                if value is String {
                    return "\'\(value)\'"
                } else {
                    return "\(value)"
                }
        }
        
        let updateQuery = zip(columns, newValues)
            .map { (column: String, value: String) -> String in
                return "\(column) = \(value)"
            }
            .joined(separator: ", ")
        
        let query = "UPDATE productsPurchases SET \(updateQuery) WHERE id = \(purchaseId) AND productId = \(productId)"
        try! service.execute(query)
    }
    
    
    
}
