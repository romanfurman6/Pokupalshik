//
//  DatabaseServiceTests.swift
//  Pokupalshik
//
//  Created by Roman Dmitrieivich on 11/23/16.
//  Copyright © 2016 Roman Dmitrieivich. All rights reserved.
//

import XCTest
@testable import Pokupalshik


class DatabaseServiceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInsertingProductToDB() {
        var product = Product(name: "Corn", price: 1.5)
        product.id = Product.service.insert(object: product)
        XCTAssertEqual(Product.service.fetchObjectBy(id: product.id), product)
        
    }
    
    func testDeletingProductFromDB() {
        var product = Product(name: "Corn", price: 1.5)
        product.id = Product.service.insert(object: product)
        _ = Product.service.deleteObject(withId: product.id)
        
        XCTAssertEqual(Product.service.fetchObjectBy(id: product.id), nil)
    }
    
    func testUpdateProductInDB() {
        var product = Product(name: "Corn", price: 1.5)
        product.id = Product.service.insert(object: product)
        var newProduct = Product(name: "Corn", price: 2)
        newProduct.id = product.id
        _ = Product.service.update(object: newProduct)
        
        XCTAssertEqual(Product.service.fetchObjectBy(id: product.id), newProduct)
    }
    
    func testInsertingPurchaseToDB() {
        var purchase = Purchase(time: NSDate())
        purchase.id = Purchase.service.insert(object: purchase)
        XCTAssertEqual(Purchase.service.fetchObjectBy(id: purchase.id), purchase)
        
    }
    
    func testDeletingPurchaseFromDB() {
        var purchase = Purchase(time: NSDate())
        purchase.id = Purchase.service.insert(object: purchase)
        _ = Purchase.service.deleteObject(withId: purchase.id)
        XCTAssertEqual(Purchase.service.fetchObjectBy(id: purchase.id), nil)
    }
    
    func testUpdatePurchaseInDB() {
        var purchase = Purchase(time: NSDate())
        purchase.id = Purchase.service.insert(object: purchase)
        var newPurchase = Purchase(time: NSDate())
        newPurchase.id = purchase.id
        _ = Purchase.service.update(object: newPurchase)
        XCTAssertEqual(Purchase.service.fetchObjectBy(id: purchase.id), newPurchase)
    }
    
}
