//
//  PhoneNumberAutoformatter.swift
//  wx
//
//  Created by wx on 4/4/19.
//  Copyright © 2019 wx. All rights reserved.
//

import Foundation

class PhoneNumberAutoformatter {
    var digitPlaceholder: Character
    var phoneMask: String
    
    init(mask: String = "XX-XX-XX", digitPlaceholder: Character = "X") {
        self.phoneMask = mask
        self.digitPlaceholder = digitPlaceholder
    }
    
    func makeAutoformat(phone: String) -> String {
        let formatted: String
        
        if let c = phone.last, !c.isNumber {
            formatted = self.makeAutotrimming(phone: phone)
        }
        else {
            formatted = self.makeAutocompletion(phone: phone)
        }
        
        return formatted
    }

    func makeProcessing(newPhone: String, oldPhone: String? = nil) -> String {
        let mask = self.restMask(forPhone: newPhone)

        let hasDigitPlaceholders = mask.contains(where: { (c) -> Bool in
            return c == self.digitPlaceholder
        })

        let output: String
        
        if
            let oldPhone = oldPhone, newPhone.count <= oldPhone.count,
            let c = oldPhone.last, !c.isNumber,
            hasDigitPlaceholders {
            
            output = self.makeAutotrimming(phone: newPhone)
        }
        else {
            output = self.makeAutocompletion(phone: newPhone)
        }
        
        return output
    }
    
    func makeAutotrimming(phone: String, removeLastDigit: Bool = true) -> String {
        var mask = self.restMask(forPhone: phone)
        var output = phone

        while let m = mask.popLast(), m != self.digitPlaceholder {
            output.removeLast()
        }
        
        if removeLastDigit, !output.isEmpty {
            output.removeLast()
        }
        
        return output
    }
    
    func makeAutocompletion(phone: String) -> String {
        var mask = self.phoneMask
        var input = phone
        var output = ""
        
        while !input.isEmpty {
            let c = input.removeFirst()
            var m = mask.removeFirst()
            
            if c != m {
                while m != self.digitPlaceholder {
                    output.append(m)
                    m = mask.removeFirst()
                }
            }
            
            output.append(c)
        }
        
        while !mask.isEmpty {
            let m = mask.removeFirst()
            
            if m != self.digitPlaceholder {
                output.append(m)
            }
            else {
                break
            }
        }
        
        return output
    }
}

fileprivate extension PhoneNumberAutoformatter {
    func restMask(forPhone phone: String) -> String {
        var mask = self.phoneMask
        let n = mask.count - phone.count
        mask.removeLast(n)
        
        return mask
    }
}
