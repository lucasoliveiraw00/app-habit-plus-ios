//
//  HabitDetailUIState.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 21/11/24.
//

import Foundation

enum HabitDetailUIState: Equatable {
    case none
    case loading
    case success
    case error(String)
}
