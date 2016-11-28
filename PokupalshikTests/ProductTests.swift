//
//  ProductTests.swift
//  Pokupalshik
//
//  Created by Roman Dmitrieivich on 11/23/16.
//  Copyright © 2016 Roman Dmitrieivich. All rights reserved.
//

import XCTest
@testable import Pokupalshik

class ProductTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDictToObjectTransform() {
        let newProduct = Product(dict: ["id": Int64(1), "name": "Beer", "price": 2.0])
        let answer = Product(id: 1, name: "Beer", price: 2)
        XCTAssertEqual(newProduct, answer)
    }
    
}
