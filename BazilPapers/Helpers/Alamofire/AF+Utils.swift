//
//  AF+Utils.swift
//  sberservice
//
//  Created by wx on 9/30/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import Foundation
import Alamofire

extension AF {
    static func postMultipartFormData(_ data: MultipartFormData, url: URL, accessTokenHeader: HTTPHeader? = nil, headers: HTTPHeaders? = nil) -> UploadRequest {
        let request = self.uploadMultipartFormData(data, url: url, method: .post, accessTokenHeader: accessTokenHeader, headers: headers)
        return request
    }
    
    static func postApplicationJSON(_ jsonData: Any, url: URL, accessTokenHeader: HTTPHeader? = nil, headers: HTTPHeaders? = nil) throws -> DataRequest {
        let request = try self.requestWithJSON(jsonData, url: url, method: .post, accessTokenHeader: accessTokenHeader, headers: headers)
        return request
    }

    static func putApplicationJSON(_ jsonData: Any, url: URL, accessTokenHeader: HTTPHeader? = nil, headers: HTTPHeaders? = nil) throws -> DataRequest {
        let request = try self.requestWithJSON(jsonData, url: url, method: .put, accessTokenHeader: accessTokenHeader, headers: headers)
        return request
    }

    static func post(url: URL, accessTokenHeader: HTTPHeader? = nil, headers: HTTPHeaders? = nil) -> DataRequest {
        let request = self.request(url: url, method: .post, accessTokenHeader: accessTokenHeader, headers: headers)
        return request
    }
    
    static func get(url: URL, accessTokenHeader: HTTPHeader? = nil, headers: HTTPHeaders? = nil) -> DataRequest {
        let request = self.request(url: url, method: .get, accessTokenHeader: accessTokenHeader, headers: headers)
        return request
    }
    
    static func delete(url: URL, accessTokenHeader: HTTPHeader? = nil, headers: HTTPHeaders? = nil) -> DataRequest {
        let request = self.request(url: url, method: .delete, accessTokenHeader: accessTokenHeader, headers: headers)
        return request
    }
    
}

fileprivate extension AF {
    static func uploadMultipartFormData(_ data: MultipartFormData, url: URL, method: HTTPMethod, accessTokenHeader: HTTPHeader? = nil, headers: HTTPHeaders? = nil) -> UploadRequest {
        var allHeaders = headers ?? HTTPHeaders()
        
        if let h = accessTokenHeader {
            allHeaders.add(h)
        }
        
        let r = self.upload(multipartFormData: data, to: url, method: .post, headers: allHeaders)
        return r
    }
    
    static func uploadApplicationJSON(_ jsonData: Data, url: URL, method: HTTPMethod, accessTokenHeader: HTTPHeader? = nil, headers: HTTPHeaders? = nil) -> UploadRequest {
        var allHeaders = headers ?? HTTPHeaders()
        
        let contentType = HTTPHeader.contentType(URLRequest.HTTPHeaderValue.ApplicationJSON.rawValue)
        allHeaders.add(contentType)

        if let h = accessTokenHeader {
            allHeaders.add(h)
        }
        
        let r = self.upload(jsonData, to: url, method: method, headers: allHeaders)
        return r
    }
    
    static func request(url: URL, method: HTTPMethod, accessTokenHeader: HTTPHeader? = nil, headers: HTTPHeaders? = nil) -> DataRequest {
        var allHeaders = headers ?? HTTPHeaders()
        
        if let h = accessTokenHeader {
            allHeaders.add(h)
        }
        
        let r = self.request(url, method: method, headers: allHeaders)
        return r
    }

    static func requestWithJSON(_ jsonData: Any, url: URL, method: HTTPMethod, accessTokenHeader: HTTPHeader? = nil, headers: HTTPHeaders? = nil) throws -> DataRequest {
        var allHeaders = headers ?? HTTPHeaders()
        
        if let h = accessTokenHeader {
            allHeaders.add(h)
        }

        let contentType = HTTPHeader.contentType(URLRequest.HTTPHeaderValue.ApplicationJSON.rawValue)
        allHeaders.add(contentType)

        var request = try URLRequest(url: url, method: method, headers: allHeaders)
        request.httpBody = try JSONSerialization.data(withJSONObject: jsonData)
        
        let r = self.request(request)
        return r
    }
}
