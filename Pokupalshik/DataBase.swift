//
//  DataBase.swift
//  Pokupalshik
//
//  Created by Roman Dmitrieivich on 11/7/16.
//  Copyright © 2016 Roman Dmitrieivich. All rights reserved.
//

import Foundation
import SQLite


protocol DatabaseManagable {
    var tableName: String {get set}
    var fields: [String] {get set}
}

struct Purchases: DatabaseManagable {
    var fields: [String] = ["id","time"]
    var db = DatabaseService()
    internal var tableName: String = "purchases"
    var arr: [[AnyObject]] = []
    init() {
        self.arr = db.fetchObjects(withType: self)
    }
}

struct Product: DatabaseManagable {
    var fields: [String] = ["id","name","price"]
    var db = DatabaseService()
    internal var tableName: String = "products"
    var arr: [[AnyObject]] = []
    init() {
        self.arr = db.fetchObjects(withType: self)
    }
}

class DatabaseService {
    var db: Connection?
    
    init() {
        self.databaseConnect(to: "PokupalshikDB", withType: "db")
    }
    
    func databaseConnect(to: String, withType: String) {
        guard let path = Bundle.main.path(forResource: "\(to)", ofType: "\(withType)") else {
            fatalError("💩")
        }
        do {
            db = try Connection(path)
            print("connected")
        } catch {
            print(error)
        }
    }
    
    func fetchObjects<T:DatabaseManagable>(withType: T) -> [[AnyObject]] {
        var array: [[AnyObject]] = []
        guard let result = try? db?.prepare("SELECT * FROM \(withType.tableName)") else {
            fatalError()
        }
        for row in result! {
            array.append(row as [AnyObject])
        }
        return array
    }
}
    func insertObject<T:DatabaseManagable>(withType: T) { //TODO
//        let id = try! db!.scalar(products.count)
//        print(id)
//        let insert = products.insert(identifier <- (id+1), nameOfProduct <- "\(name)", priceOfProduct <- price )
//        _ = try! db?.run(insert)
    }









/*
class DatabaseSevice {
    var db: Connection?
    var arrayOfProducts: [[AnyObject]] = []
    let products = Table("products")
    var nameOfProduct = Expression<String>("name")
    var priceOfProduct = Expression<Double>("price")
    var identifier = Expression<Int>("id")
    
    init(to: String, type: String) {
        self.databaseConnect(to: to, withType: type)
        fetchObjects()
    }
    
    func databaseConnect(to: String, withType: String) {
        guard let path = Bundle.main.path(forResource: "\(to)", ofType: "\(withType)") else {
            fatalError("💩")
        }
        do {
            db = try Connection(path)
            print("connected")
        } catch {
            print(error)
        }
    }
    
    func fetchObjects() {
        arrayOfProducts = []
        guard let result = try? db?.prepare("SELECT * FROM products") else {
            fatalError()
        }
        for row in result! {
           arrayOfProducts.append(row as [AnyObject])
        }
    }
    
    func insertObject(name: String, price: Double) {
        let id = try! db!.scalar(products.count)
        print(id)
        let insert = products.insert(identifier <- (id+1), nameOfProduct <- "\(name)", priceOfProduct <- price )
        _ = try! db?.run(insert)
    }
    
    func deleteObject(deleteId: Int) {
        let count = try! db!.scalar(products.count)
        if count > 0 {
            let deleteItem = products.filter(identifier == deleteId)
            _ = try! db!.run(deleteItem.delete())
        }
    }
}
*/


