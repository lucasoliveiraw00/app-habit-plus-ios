//
//  HabitViewModel.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 12/11/24.
//

import Foundation

class HabitViewModel: ObservableObject {
    
    @Published var uiState: HabitUIState = .empytList
    
    @Published var title = "Atenção"
    @Published var headline = "Fique ligado!"
    @Published var desc = "Você está atrasado nos hábitos"
}
