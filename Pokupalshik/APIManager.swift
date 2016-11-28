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
    
    static let shared = APIManager()
    
    func getCurrencies(completionHandler: @escaping ([Currency]?, Error?) -> Void) {
        Alamofire.request("http://api.fixer.io/latest?base=USD",encoding: JSONEncoding.default)
            .responseJSON { response in
                DispatchQueue.main.async {
                    switch response.result {
                    case .success(let json):
                        guard
                            let json = json as? JSON,
                            let dict = json["rates"] as? JSON
                            else {
                                completionHandler(nil, NetworkError.invalidJSON)
                                return
                        }
                        
                        let currencies = dict.map { (key, value) -> JSON in
                            return [key:value]
                            }
                            .flatMap {
                                Currency(from: $0)
                        }
                        
                        completionHandler(currencies, nil)
                    case .failure(let error):
                        completionHandler(nil, error)
                    }
                }
        }
    }
}

