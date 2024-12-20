//
//  Mask.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 24/11/24.
//

import Foundation

class Mask {
    
    static var isUpdating = false
    static var oldString = ""
    
    private static func replaceChars(full: String) -> String {
        return full
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "-", with: "")
            .replacingOccurrences(of: "(", with: "")
            .replacingOccurrences(of: ")", with: "")
            .replacingOccurrences(of: ".", with: "")
            .replacingOccurrences(of: "/", with: "")
            .replacingOccurrences(of: ",", with: "")
    }
    
    static func mask(mask: String, value: String, text: inout String) {
        let str = Mask.replaceChars(full: value)
        var cpfWithMask = ""
        
        var _mask = mask
        
        if _mask == "(##) ####-####" {
            if value.count >= 14 && value.characterAtIndex(index: 5) == "9" {
                _mask = "(##) #####-####"
            }
        }
        
        if str <= oldString {
            isUpdating = true
            if _mask == "(##) #####-####" && value.count == 14 {
                _mask = "(##) ####-####"
            }
        }
        
        if isUpdating || value.count == _mask.count {
            oldString = str
            isUpdating = false
            return
        }
        
        var i = 0
        for char in _mask {
            if char != "#" && str.count > oldString.count {
                cpfWithMask.append(char)
                continue
            }
            
            guard let unmaskedChar = str.characterAtIndex(index: i) else {
                break
            }
            cpfWithMask.append(unmaskedChar)
            i += 1
        }
        
        isUpdating = true
        if cpfWithMask == "(0" {
            text = ""
            return
        }
        
        text = cpfWithMask
    }
    
}
