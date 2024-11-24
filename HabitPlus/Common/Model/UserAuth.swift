//
//  UserAuth.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 31/10/24.
//

import Foundation

struct UserAuth: Codable {
    let acessToken: String
    let refreshToken: String
    let expires: Double
    let tokenType: String
    
    enum CodingKeys: String, CodingKey {
        case acessToken = "access_token"
        case refreshToken = "refresh_token"
        case expires
        case tokenType = "token_type"
    }
}
