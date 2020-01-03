//
//  URLRequest+MultipartFormData.swift
//  sberservice
//
//  Created by User on 9/11/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import Foundation

public extension URLRequest {
    enum MultipartFormDataEncodingError: Error {
        case undefined
        case unrecognizedCharacterSetName
        case name(String)
        case value(String, name: String)
    }
    
    mutating func setMultipartFormData(_ parameters: [String: String], encoding: String.Encoding = .utf8) throws {
        let makeRandom = {
            return UInt32.random(in: (.min)...(.max))
        }
        
        let boundary = String(format: "------------------------%08X%08X", makeRandom(), makeRandom())
        
        guard
            let CRLF = "\r\n".data(using: .utf8),
            let partBorderLabel = "--\(boundary)".data(using: .utf8),
            let lastPartBorderLabel = "--\(boundary)--".data(using: .utf8)
            else {
                throw MultipartFormDataEncodingError.undefined
        }
        
        let contentType: String = try {
            let encodingName = CFStringConvertNSStringEncodingToEncoding(encoding.rawValue)
            
            guard let charset = CFStringConvertEncodingToIANACharSetName(encodingName) else {
                throw MultipartFormDataEncodingError.unrecognizedCharacterSetName
            }
            
            let c = "multipart/form-data; charset=\(charset); boundary=\(boundary)"
            return c
        }()
        
        self.addValue(contentType, forHTTPHeaderField: "Content-Type")
        
        self.httpBody = try {
            var body = Data()
            
            for (rawName, rawValue) in parameters {
                if !body.isEmpty {
                    body.append(CRLF)
                }
                
                body.append(partBorderLabel)
                body.append(CRLF)
                
                let rawContentDisposition = "Content-Disposition: form-data; name=\"\(rawName)\""
                
                guard
                    rawName.canBeConverted(to: encoding),
                    let contentDisposition = rawContentDisposition.data(using: encoding)
                    else {
                        throw MultipartFormDataEncodingError.name(rawName)
                }
                
                body.append(contentDisposition)
                body.append(CRLF)
                body.append(CRLF)
                
                guard let value = rawValue.data(using: encoding) else {
                    throw MultipartFormDataEncodingError.value(rawValue, name: rawName)
                }
                
                body.append(value)
            }
            
            body.append(CRLF)
            body.append(lastPartBorderLabel)
            body.append(CRLF)
            
            return body
        }()
    }
}
