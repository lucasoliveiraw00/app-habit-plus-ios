//
//  HabitCreateUIState.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 23/11/24.
//

import Foundation

enum HabitCreateUIState: Equatable {
    case none
    case loading
    case success
    case error(String)
}
