//
//  SignInResponse.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 28/10/24.
//

import Foundation
 
struct SignInResponse: Decodable {
    let acessToken: String
    let refreshToken: String
    let expires: Int
    let tokenType: String
    
    enum CodingKeys: String, CodingKey {
        case acessToken = "access_token"
        case refreshToken = "refresh_token"
        case expires
        case tokenType = "token_type"
    }
}
