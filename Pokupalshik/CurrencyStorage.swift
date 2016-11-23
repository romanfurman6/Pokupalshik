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
        static let CurrencyName = "CurrencyName"
        static let CurrencyCoef = "CurrencyCoef"
    }
    
    let defaults = UserDefaults.standard
    static let shared = CurrencyStorage()
    var currentCurrency: Currency {
        set {
            defaults.set(newValue.jsonValue, forKey: "currentCurrency")
        }
        get {
            guard let dict = defaults.dictionary(forKey: "currentCurrency") else {
                return Currency(name: "USD", coef: 1.0)
            }
            return Currency(name: (dict.first?.key)!, coef: dict.first?.value as! Double)
        }
    }
}
