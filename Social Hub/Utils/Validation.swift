//
//  Validation.swift
//  Social Hub
//
//  Created by Jonathan Dowdell on 12/18/18.
//  Copyright © 2018 Jonathan Dowdell. All rights reserved.
//

import Foundation

class Validation {
    
    static let shared = Validation()
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    public func validPassword(pwd:String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^.*(?=.{6,})(?=.*[A-Z])(?=.*[a-zA-Z])(?=.*\\d)|(?=.*[!#$%&?,.;@]).*$")
        return passwordTest.evaluate(with:pwd)
    }
    
    
    
}

extension Double {
    var kmFormatted: String {
        
        if self >= 10000, self <= 999999 {
            return String(format: "%.1fK", locale: Locale.current,self/1000).replacingOccurrences(of: ".0", with: "")
        }
        
        if self > 999999 {
            return String(format: "%.1fM", locale: Locale.current,self/1000000).replacingOccurrences(of: ".0", with: "")
        }
        
        return String(format: "%.0f", locale: Locale.current,self)
    }
}
