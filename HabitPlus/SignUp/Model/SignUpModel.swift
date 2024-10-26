//
//  SignUpModel.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 20/10/24.
//

import Foundation

enum SignUpUIState: Equatable {
    case none
    case loading
    case success
    case error(String)
}
