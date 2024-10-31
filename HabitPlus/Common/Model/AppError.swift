//
//  AppError.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 30/10/24.
//

import Foundation

enum AppError: Error {
    case response(message: String)
    
    public var message: String {
        switch self {
        case .response(let message):
            return message
        }
    }
}
