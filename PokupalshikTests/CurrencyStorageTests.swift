//
//  PokupalshikTests.swift
//  PokupalshikTests
//
//  Created by Roman Dmitrieivich on 11/23/16.
//  Copyright © 2016 Roman Dmitrieivich. All rights reserved.
//

import XCTest
@testable import Pokupalshik

class PokupalshikTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        super.tearDown()
        
    }
    
    func testCurrencyToJsonValueTransform() {
        CurrencyStorage.shared.currentCurrency = Currency(name: "USD", coef: 1.0)
        let getJson = CurrencyStorage.shared.currentCurrency.jsonValue as! [String:Double]
        XCTAssertEqual(getJson, ["USD":1.0])
    }
    
}
