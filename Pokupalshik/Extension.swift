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

extension DateFormatter {
    convenience init(dateFormat: String) {
        self.init()
        self.dateFormat =  dateFormat
    }
}

extension NSDate {
    struct Formatter {
        static let custom = DateFormatter(dateFormat: "H:mm / dd.M.yyyy")
    }
    var customFormatted: String {
        Formatter.custom.timeZone = TimeZone(abbreviation: "GMT+2")
        return Formatter.custom.string(from: self as Date)
    }
}

extension String {
    var asDate: NSDate? {
        return NSDate.Formatter.custom.date(from: self) as NSDate?
    }
    func asDateFormatted(with dateFormat: String) -> NSDate? {
        return DateFormatter(dateFormat: dateFormat).date(from: self) as NSDate?
    }
}
