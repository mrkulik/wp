//
//  URLRequest+HTTPMethods.swift
//  sberservice
//
//  Created by User on 9/11/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import Foundation

public extension URLRequest {
    enum HTTPMethod: String {
        case Uninitialized = ""
        case Unknown = "Unknown"
        
        case POST = "POST"
        case GET = "GET"
        case PUT = "PUT"
    }
    
    var method: HTTPMethod {
        set {
            self.httpMethod = newValue.rawValue
        }
        get {
            let value = HTTPMethod(rawValue: self.httpMethod ?? "") ?? HTTPMethod.Unknown
            return value
        }
    }
}
