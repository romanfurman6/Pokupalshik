//
//  PurchaseTests.swift
//  Pokupalshik
//
//  Created by Roman Dmitrieivich on 11/23/16.
//  Copyright © 2016 Roman Dmitrieivich. All rights reserved.
//

import XCTest
@testable import Pokupalshik


class PurchaseTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDictToObjectTransform() {
        let newPurchase = Purchase(dict: ["id": Int64(1), "time": Int64(13000000)])
        let answer = Purchase(id: 1,time: NSDate(timeIntervalSinceReferenceDate: TimeInterval(exactly: 13000000.0)!))
        XCTAssertEqual(newPurchase,answer)
    }
    
}
