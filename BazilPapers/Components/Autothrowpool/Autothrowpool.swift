//
//  Autothrowpool.swift
//  Internal
//
//  Created by wx on 28.06.2018.
//  Copyright © 2018 wx. All rights reserved.
//

import Foundation

/*
    Works with throw of Errors like NSAutoreleasepool class works with [NSObject release]
 
    Usage:
 
    let p1 = Autothrowpool()
 
    NSError(domain: "11", code: 1, userInfo: nil).autothrow()
    NSError(domain: "22", code: 1, userInfo: nil).autothrow()
 
    let p2 = Autothrowpool()
 
    NSError(domain: "33", code: 1, userInfo: nil).autothrow()
 
    do {
        try p2.drain(domain: "throw pool two", code: 1000, userInfo: nil)
    }
    catch {
        print(error)
    }
 
    NSError(domain: "44", code: 1, userInfo: nil).autothrow()
 
    do {
        try p1.drain(domain: "throw pool one", code: 1000, userInfo: nil)
    }
    catch {
        let e = error as NSError
        let i = e.userInfo
        if let d = i[e.domain] {
            print(d)
        }
    }
 
 */

extension Error {
    func autothrow() {
        Thread.current.autothrowpoolStack?.currentPool?.autothrow(with: self)
    }
}

final class Autothrowpool: NSObject {
    var defaultError: AutothrowpoolError {
        let domain = String.autothrowpoolDefaultDomain
        let info = [
            domain: self.errors
        ]
        
        let e = AutothrowpoolError(domain: domain, code: -1, userInfo: info)
        return e
    }
    
    private (set) var errors: [Error] = []
    
    private weak var autothrowpoolStack: AutothrowpoolStack?
    
    // MARK: - Life cycle
    override init() {
        super.init()
        
        let thread = Thread.current
        
        if thread.autothrowpoolStack == nil {
            thread.autothrowpoolStack = AutothrowpoolStack()
        }
        
        self.autothrowpoolStack = thread.autothrowpoolStack
        
        self.autothrowpoolStack?.pushPool(self)
    }
    
    deinit {
        self.autothrowpoolStack?.popPools(with: self)
    }
    
    func drain(domain: String = .autothrowpoolDefaultDomain, code: Int = -1, userInfo: [String: Any]? = nil) throws {
        guard let allPools = self.autothrowpoolStack?.allPools else {
            return
        }
        
        var iterator = allPools.makeIterator()
        
        var needsDrain = false
        
        while let pool = iterator.next() {
            if pool === self {
                needsDrain = true
                break
            }
        }
        
        guard needsDrain else {
            return
        }
        
        var allErrors: [Error] = []
        
        allErrors.append(contentsOf: self.errors)
        self.flush()
        
        while let pool = iterator.next() {
            allErrors.append(contentsOf: pool.errors)
            pool.flush()
        }
        
        if !allErrors.isEmpty {
            var info = userInfo ?? [:]
            info[domain] = allErrors
            
            throw AutothrowpoolError(domain: domain, code: code, userInfo: info)
        }
    }
}

fileprivate extension Autothrowpool {
    func flush() {
        self.errors.removeAll()
    }
    
    func autothrow(with error: Error) {
        self.errors.append(error)
    }
}

fileprivate extension String {
    static let autothrowpoolDefaultDomain = "Autothrowpool"
}

fileprivate extension Thread {
    private struct AssociatedKeys {
        static var autothrowpoolStack = "AssociatedAutothrowpoolStack"
    }
    
    var autothrowpoolStack: AutothrowpoolStack? {
        get {
            let p = objc_getAssociatedObject(self, &AssociatedKeys.autothrowpoolStack) as? AutothrowpoolStack
            return p
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.autothrowpoolStack, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

fileprivate class AutothrowpoolStack: NSObject {
    private (set) var stack = WeakStack<Autothrowpool>()

    var currentPool: Autothrowpool? {
        return self.stack.head()
    }

    var allPools: [Autothrowpool]? {
        return self.stack.allElements()
    }

    func pushPool(_ pool: Autothrowpool) {
        self.stack.push(pool)
    }
    
    func popPools(with pool: Autothrowpool) {
        guard self.stack.contains(pool) else {
            return
        }
        
        while let e = self.stack.pop(), e !== pool {
            e.flush()
        }
    }
}
