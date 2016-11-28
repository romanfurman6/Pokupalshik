//
//  CurrencyStorage.swift
//  Pokupalshik
//
//  Created by Roman Dmitrieivich on 11/20/16.
//  Copyright © 2016 Roman Dmitrieivich. All rights reserved.
//

import Foundation

class CurrencyStorage {
    
    private struct Keys {
        static let Currency = "Currency"
    }
    
    static let shared = CurrencyStorage()
    
    var currentCurrency: Currency {
        set {
            UserDefaults.standard.set(newValue.jsonValue, forKey: Keys.Currency)
        }
        get {
            guard
                let dict = UserDefaults.standard.dictionary(forKey: Keys.Currency),
                let currency = Currency(from: dict)
            else {
                return Currency(name: "USD", coef: 1.0)
            }
            
            return currency
        }
    }
}
