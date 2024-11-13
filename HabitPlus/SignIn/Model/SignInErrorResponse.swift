//
//  SignInErrorResponse.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 29/10/24.
//

import Foundation

struct SignInErrorResponse: Decodable {
    let detail: SignInDetailErrorResponse
    
    enum CodingKeys: String, CodingKey {
        case detail
    }
}

struct SignInDetailErrorResponse: Decodable {
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case message
    }
}


