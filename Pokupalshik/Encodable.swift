//
//  Encodable.swift
//  Pokupalshik
//
//  Created by Roman Dmitrieivich on 11/23/16.
//  Copyright © 2016 Roman Dmitrieivich. All rights reserved.
//

import Foundation

protocol Encodable {
    var jsonValue: JSON { get }
}
