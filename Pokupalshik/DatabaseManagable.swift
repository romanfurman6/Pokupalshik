//
//  DatabaseManagable.swift
//  Pokupalshik
//
//  Created by Roman Dmitrieivich on 11/9/16.
//  Copyright © 2016 Roman Dmitrieivich. All rights reserved.
//

import Foundation

protocol DatabaseManagable {
    
    static var tableName: String { get }
    init?(dict: [String:Any])
    var id: Int64 { get set }
    var fields: [String: Any] { get }
    
}
