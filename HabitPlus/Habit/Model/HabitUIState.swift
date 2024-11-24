//
//  HabitModel.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 12/11/24.
//

import Foundation

enum HabitUIState {
    case loading
    case emptyList
    case fullList([HabitCardViewModel])
    case error(String)
}
