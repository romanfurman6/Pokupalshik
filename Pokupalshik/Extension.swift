//
//  Extension.swift
//  Pokupalshik
//
//  Created by Roman Dmitrieivich on 11/11/16.
//  Copyright © 2016 Roman Dmitrieivich. All rights reserved.
//

import Foundation

extension Double {

    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
