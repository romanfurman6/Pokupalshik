//
//  CurrencyTest.swift
//  Pokupalshik
//
//  Created by Roman Dmitrieivich on 11/23/16.
//  Copyright © 2016 Roman Dmitrieivich. All rights reserved.
//

import XCTest
@testable import Pokupalshik

class CurrencyTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testJsonValueToCurrencyTransform() {
        let currency = Currency(from: ["EUR":0.9423141])
        let answer = Currency(name: "EUR", coef: 0.9423141)
        XCTAssertEqual(currency!, answer)
    }
    
}
