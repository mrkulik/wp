//
//  DataMapper.swift
//  sberservice
//
//  Created by User on 9/20/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import Foundation

class DataMapper {
    var parent: DataMapper?
    
    var makeChild: DataMapper {
        let p = DataMapper()
        p.parent = self
        
        return p
    }
    
    private (set) var returningMappers: [String: Any] = [:]
    private (set) var returningMappersWithContext: [String: Any] = [:]
    
    private (set) var voidMappers: [String: Any] = [:]
    private (set) var voidMappersWithContext: [String: Any] = [:]
}

// MARK: - Returning mappers
extension DataMapper {
    func registerReturningMapper<Source, Destination>(forFieldName name: String, mapper: @escaping (_ source: Source) -> Destination?) {
        let key = "\(name):\(Source.self)->\(Destination.self)"
        
        self.returningMappers[key] = mapper
    }
    
    func map<Source, Destination>(forFieldName name: String, source: Source) -> Destination? {
        let key = "\(name):\(Source.self)->\(Destination.self)"
        
        guard let makeMap = self.returningMappers[key] as? ((Source) -> Destination?) else {
            return nil
        }
        
        return makeMap(source)
    }
}

// MARK: - Returning mappers with context
extension DataMapper {
    func registerReturningMapperWithContext<Source, Destination, Context>(forFieldName name: String, mapper: @escaping (_ source: Source, _ context: Context) -> Destination?) {
        let key = "\(name):\(Source.self)->\(Destination.self)"
        
        self.returningMappersWithContext[key] = mapper
    }
    
    func map<Source, Destination, Context>(forFieldName name: String, source: Source, withContext context: Context) -> Destination? {
        let key = "\(name):\(Source.self)->\(Destination.self)"

        let result: Destination?
        
        if let makeMap = self.returningMappersWithContext[key] as? ((Source, Context) -> Destination?) {
            result = makeMap(source, context)
        }
        else if let makeMap = self.returningMappers[key] as? ((Source) -> Destination?) {
            result = makeMap(source)
        }
        else {
            result = nil
        }

        return result
    }
}

// MARK: - Void mappers
extension DataMapper {
    func registerVoidMapper<Source, Destination>(forFieldName name: String, mapper: @escaping (_ source: Source, _ destination: Destination) -> Void) {
        let key = "\(name):\(Source.self)->\(Destination.self)"
        
        self.voidMappers[key] = mapper
    }

    func voidMap<Source, Destination>(forFieldName name: String, source: Source, destination: Destination) {
        let key = "\(name):\(Source.self)->\(Destination.self)"
        
        guard let makeMap = self.voidMappers[key] as? ((Source, Destination) -> Void) else {
            return
        }
        
        makeMap(source, destination)
    }
}

// MARK: - Void mappers with context
extension DataMapper {
    func registerVoidMapperWithContext<Source, Destination, Context>(forFieldName name: String, mapper: @escaping (_ source: Source, _ destination: Destination, _ context: Context) -> Void) {
        let key = "\(name):\(Source.self)->\(Destination.self)"
        
        self.voidMappersWithContext[key] = mapper
    }
    
    func voidMap<Source, Destination, Context>(forFieldName name: String, source: Source, destination: Destination, context: Context) {
        let key = "\(name):\(Source.self)->\(Destination.self)"
        
        guard let makeMap = self.voidMappersWithContext[key] as? ((Source, Destination, Context) -> Void) else {
            return
        }
        
        makeMap(source, destination, context)
    }
}
