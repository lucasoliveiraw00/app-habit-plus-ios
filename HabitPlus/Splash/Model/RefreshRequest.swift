//
//  RefreshRequest.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 01/11/24.
//

import Foundation

struct RefreshRequest: Encodable {
    let token: String
    
    enum CodingKeys: String, CodingKey {
        case token = "refresh_token"
    }
}
