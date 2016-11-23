//
//  Currency.swift
//  Pokupalshik
//
//  Created by Roman Dmitrieivich on 11/20/16.
//  Copyright © 2016 Roman Dmitrieivich. All rights reserved.
//

import Foundation

class Currency: Decodable {
    var name: String
    var coef: Double
    
    init(name: String, coef: Double) {
        self.name = name
        self.coef = coef
    }
    
    required init?(from json: JSON) {
        guard
            let name = json.first?.key,
            let coef = json.first?.value as? Double
            else {
                return nil
        }
        self.name = name
        self.coef = coef
    }
}

extension Currency: Encodable {
    var jsonValue: JSON {
        return [name:coef]
    }
}
