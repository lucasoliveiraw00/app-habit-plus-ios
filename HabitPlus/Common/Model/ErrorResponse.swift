//
//  ErrorResponse.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 28/10/24.
//

import Foundation

struct ErrorResponse: Decodable {
    let detail: String
    
    enum CodingKeys: String, CodingKey {
        case detail
    }
}


