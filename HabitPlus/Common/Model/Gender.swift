//
//  Gender.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 21/10/24.
//

import Foundation


enum Gender: String, CaseIterable, Identifiable {
    case male = "Masculino"
    case female = "Feminino"
    
    var id: String {
        self.rawValue
    }
}
