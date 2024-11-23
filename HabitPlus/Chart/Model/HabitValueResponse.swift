//
//  HabitValueResponse.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 23/11/24.
//

import Foundation

struct HabitValueResponse: Decodable {
    let id: Int
    let value: Int
    let habitId: Int
    let createdDate: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case value
        case habitId = "habit_id"
        case createdDate = "created_date"
    }
}
