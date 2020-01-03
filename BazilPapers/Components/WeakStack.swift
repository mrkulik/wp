//
//  WeakStack.swift
//  Internal
//
//  Created by wx on 28.06.2018.
//  Copyright © 2018 wx. All rights reserved.
//

import Foundation

struct WeakStack<Element: AnyObject> {
    private var wrappedElements: [WeakWrapper<Element>] = []
    
    mutating func head() -> Element? {
        self.flush()
        
        return self.wrappedElements.last?.element
    }
    
    mutating func push(_ element: Element) {
        self.flush()
        
        let w = WeakWrapper<Element>()
        w.element = element
        
        self.wrappedElements.append(w)
    }
    
    mutating func pop() -> Element?  {
        self.flush()
        
        let e = self.wrappedElements.popLast()
        return e?.element
    }
    
    mutating func isEmpty() -> Bool {
        self.flush()
        
        return self.wrappedElements.isEmpty
    }
    
    mutating func contains(_ element: Element) -> Bool {
        self.flush()
        
        let contains = self.wrappedElements.contains { (w) -> Bool in
            return w.element === element
        }
        
        return contains
    }
    
    mutating func flush() {
        self.wrappedElements = self.wrappedElements.filter { (w) -> Bool in
            return w.element != nil
        }
    }
    
    mutating func allElements() -> [Element]? {
        let elements = self.wrappedElements.compactMap { (w) -> Element? in
            return w.element
        }
        
        return elements
    }
}

fileprivate class WeakWrapper<Element: AnyObject> {
    weak var element: Element?
}
