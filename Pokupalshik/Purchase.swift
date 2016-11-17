//
//  Purchase.swift
//  Pokupalshik
//
//  Created by Roman Dmitrieivich on 11/9/16.
//  Copyright © 2016 Roman Dmitrieivich. All rights reserved.
//

import Foundation
import SQLite

struct Purchases {
    
    static let service = DatabaseService<Purchases>()
    
    static var tableName = "purchases"
    
    var id: Int64 = 0
    var time: NSDate
    var price: Double

    
    fileprivate struct Keys {
        static let id = "id"
        static let time = "time"
        static let price = "price"

    }

}

extension Purchases: DatabaseManagable {
    init?(dict:[String:Any]) {
        
        guard
            let id = dict[Keys.id] as? Int64,
            let time = dict[Keys.time] as? Int64,
            let price = dict[Keys.price] as? Double
        
            else {
                return nil
        }
        
        self.id = id
        self.time = NSDate(timeIntervalSinceReferenceDate: Double(time))
        self.price = price.roundTo(places: 2)

    }
    
    init(time: NSDate, price: Double) {
        self.time = time
        self.price = price.roundTo(places: 2)
    }
    
    var fields: [String: Any] {
        return [Keys.time: Int(self.time.timeIntervalSinceReferenceDate), Keys.price:self.price]
    }
}

extension Purchases: Equatable { }
func ==(lhs: Purchases, rhs: Purchases) -> Bool {
    return lhs.id == rhs.id
}

extension Purchases: Hashable {
    var hashValue: Int {
        return Int(id)
    }
}
