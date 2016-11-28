//
//  Decodable.swift
//  Pokupalshik
//
//  Created by Roman Dmitrieivich on 11/23/16.
//  Copyright © 2016 Roman Dmitrieivich. All rights reserved.
//

import Foundation

protocol Decodable {
    init?(from json: JSON)
}
