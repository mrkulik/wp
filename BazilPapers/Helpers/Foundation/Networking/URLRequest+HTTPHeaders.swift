//
//  URLRequest+HTTPHeaders.swift
//  sberservice
//
//  Created by User on 9/11/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import Foundation

public extension URLRequest {
    enum HTTPHeader: String {
        case Accept = "accept"
        case ContentType = "Content-Type"
    }
    
    enum HTTPHeaderValue: String {
        case Uninitialized = ""
        case Unknown = "Unknown"
        
        case ApplicationJSON = "application/json"
        
        case MultipartFormData = "multipart/form-data"
    }
    
    mutating func addHeaderValue(_ value: HTTPHeaderValue, forHeader header: HTTPHeader) {
        self.addValue(value.rawValue, forHTTPHeaderField: header.rawValue)
    }
    
    func headerValue(forHeader header: HTTPHeader) -> HTTPHeaderValue {
        let v = self.value(forHTTPHeaderField: header.rawValue) ?? ""
        let hv = HTTPHeaderValue(rawValue: v) ?? HTTPHeaderValue.Unknown
        
        return hv
    }
}
