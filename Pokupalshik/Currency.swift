//
//  Currency.swift
//  Pokupalshik
//
//  Created by Roman Dmitrieivich on 11/20/16.
//  Copyright © 2016 Roman Dmitrieivich. All rights reserved.
//

import Foundation

class Currency {
    var name: String
    var coef: Double
    
    init(name: String, coef: Double) {
        self.name = name
        self.coef = coef
    }
}
