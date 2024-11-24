//
//  String+Extension.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 25/10/24.
//

import Foundation

extension String {
    func isEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
    
    func toDate(sourcePattern source: String, destPattern dest: String) -> String? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = source
        
        let dateFormatter = formatter.date(from: self)
        
        guard let dateFormatted = dateFormatter else {
            return nil
        }
        
        formatter.dateFormat = dest
        return formatter.string(from: dateFormatted)
    }
    
    func toDate(sourcePattern source: String) -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = source
        
        return formatter.date(from: self)
    }
    
    func characterAtIndex(index: Int) -> Character? {
        guard index >= 0 && index < self.count else {
            return nil
        }
        
        var cur = 0
        for char in self {
            if cur == index {
                return char
            }
            cur += 1
        }
        
        return nil
    }
    
}
