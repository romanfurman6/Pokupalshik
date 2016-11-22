//
//  APIManager.swift
//  Pokupalshik
//
//  Created by Roman Dmitrieivich on 11/17/16.
//  Copyright © 2016 Roman Dmitrieivich. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
    
    static let sharedAPI = APIManager()
    
    func getCurrency(completionHandler: @escaping ([String:Double]?, NSError?) -> ()) {
        Alamofire.request("http://api.fixer.io/latest?base=USD",encoding: JSONEncoding.default)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let dict = value as? [String:AnyObject]
                    let rates = dict?["rates"] as! [String: Double]
                    completionHandler(rates, nil)
                case .failure(let error):
                    completionHandler(nil, error as NSError?)
                }
        }
    }
}

