//
//  Purchase.swift
//  Pokupalshik
//
//  Created by Roman Dmitrieivich on 11/9/16.
//  Copyright © 2016 Roman Dmitrieivich. All rights reserved.
//

import Foundation
import SQLite

struct Purchase: DatabaseManagable {
    
    static let service = DatabaseService<Purchase>()
    
    static var tableName = "purchases"
    
    var id: Int64 = 0
    var time: NSDate
    
    private struct Keys {
        static let id = "id"
        static let time = "time"
    }
    
    init?(dict:[String:Any]) {
        
        guard
            let id = dict[Keys.id] as? Int64,
            let time = dict[Keys.time] as? Int64
            
            else {
                return nil
        }
    
        self.id = id
        self.time = NSDate(timeIntervalSinceReferenceDate: Double(time))
    }
    
    init(time: NSDate) {
        self.time = time
    }

    var fields: [String: Any] {
        return [Keys.time: Int(self.time.timeIntervalSinceReferenceDate)]
    }
}

