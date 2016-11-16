//
//  DatabaseService.swift
//  Pokupalshik
//
//  Created by Roman Dmitrieivich on 11/9/16.
//  Copyright © 2016 Roman Dmitrieivich. All rights reserved.
//

import Foundation
import SQLite

class DatabaseService<Z: DatabaseManagable> {
    
    var service: Connection
    
    init() {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let documentsDatabaseURL = documentsURL.appendingPathComponent("PokupalshikDB.db")

        self.service = try! Connection(documentsDatabaseURL.path)
    }
    
    func update(object: Z) {
        let array = object.fields.map { $0 }
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
        
        let query = "UPDATE \(Z.tableName) SET \(updateQuery) WHERE id = \(object.id)"
        try! service.execute(query)
    }
    
    func update(id: Int64, field: String, newValue: Any) {
        let query = "UPDATE \(Z.tableName) SET \(field) = \'\(newValue)\' WHERE id = \(id)"
        try! self.service.execute(query)
    }

    func fetchObjectBy(id: Int64) -> Z? {
        let result = try! service.prepare("SELECT * FROM \(Z.tableName) WHERE id = \(id)")
        var dict = [String: Any]()
        Array(result).first?.enumerated().forEach {(index,value) in
            dict[result.columnNames[index]] = value
        }
        return Z.init(dict: dict)
    }

    func fetchObjects() -> [Z] {
        guard let result = try? service.prepare("SELECT * FROM \(Z.tableName)") else {
            fatalError()
        }
        let z: [Z] = result.map { row -> [String : Any] in
            
            var dict = [String: Any]()
            row
                .enumerated()
                .forEach { (index, item) in
                    dict[result.columnNames[index]] = item
            }
            
            return dict
            }.flatMap { Z(dict: $0) }
        print("z=\(z)")
        return z
    }
    
    func insert(object: Z) -> Int64 {
        let array = object.fields.map { $0 }
        let columns = array.map { $0.0 }.map { "\"\($0)\"" } as [String]
        let columnsString = columns.joined(separator: ", ")
        
        let newValues = array
            .map { $0.1 }
            .map { value -> String in
                if value is String {
                    return "\'\(value)\'"
                } else {
                    return "\(value)"
                }
        }
        let newValuesString = newValues.joined(separator: ", ")
        let query = "INSERT INTO \(Z.tableName) (\(columnsString)) VALUES (\(newValuesString))"
        try! self.service.execute(query)
        
        return service.lastInsertRowid!
    }
    
    func deleteObject(withId: Int64) {
        let query = "DELETE FROM \(Z.tableName) WHERE ID = \(withId)"
        try! self.service.execute(query)
    }
}

