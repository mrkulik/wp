//
//  KeyValuedURLComponents.swift
//  sberservice
//
//  Created by User on 8/27/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import Foundation

struct KeyValuedURLComponents {
    let components: URLComponents?
    
    private var keyedValues: [String: String] = [:]
    
    init(_ components: URLComponents) {
        self.components = components
        
        self.components?.queryItems?.forEach({ (i) in
            self.keyedValues[i.name] = i.value
        })
    }

    init(_ url: URL, resolvingAgainstBaseURL: Bool = true) {
        self.components = URLComponents(url: url, resolvingAgainstBaseURL: resolvingAgainstBaseURL)
        
        self.components?.queryItems?.forEach({ (i) in
            self.keyedValues[i.name] = i.value
        })
    }
    
    func string(for key: String) -> String? {
        return self.keyedValues[key]
    }
}
