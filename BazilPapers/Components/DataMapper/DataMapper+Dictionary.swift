//
//  DataMapper+Dictionary.swift
//  sberservice
//
//  Created by User on 10/8/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import Foundation

// MARK: - Returning mappers
extension DataMapper {
    func registerReturningMapperToDictionary<Source>(forName name: String = .defaultMapperName, mapper: @escaping (_ source: Source) -> [String: Any]?) {
        self.registerReturningMapper(forFieldName: name, mapper: mapper)
    }
    
    func mapToDictionary<Source>(forName name: String = .defaultMapperName, source: Source) -> [String: Any]? {
        let o: [String: Any]? = self.map(forFieldName: name, source: source)
        return o
    }
}

// MARK: - Void mappers
extension DataMapper {
    func registerVoidMapperFromDictionary<Destination>(forName name: String = .defaultMapperName, mapper: @escaping (_ source: [String: Any], _ destination: Destination) -> Void) {
        self.registerVoidMapper(forFieldName: name, mapper: mapper)
    }

    func voidMapFromDictionary<Destination>(forName name: String = .defaultMapperName, source: [String: Any], destination: Destination) {
        self.voidMap(forFieldName: name, source: source, destination: destination)
    }
}

fileprivate extension String {
    static let defaultMapperName = ":DataMapper:Dictionary:"
}
