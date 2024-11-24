//
//  ProfileUIState.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 23/11/24.
//

import Foundation

enum ProfileUIState: Equatable {
    case none
    case loading
    case fetchSuccess
    case fetchError(String)
    
    case updateLoading
    case updateSuccess
    case updateError(String)
}
