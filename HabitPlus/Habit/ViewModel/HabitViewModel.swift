//
//  HabitViewModel.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 12/11/24.
//

import Foundation

class HabitViewModel: ObservableObject {
    
    @Published var uiState: HabitUIState = .emptyList
    
    @Published var title = "Atenção"
    @Published var headline = "Fique ligado!"
    @Published var desc = "Você está atrasado nos hábitos"
    
    @Published var showErrorAlert: Bool = false
}

extension HabitViewModel {
    var errorMessage: String {
        if case let HabitUIState.error(msg) = uiState {
            return msg
        }
        return "Erro desconhecido"
    }
    
    func onAppearAlert() {
        if case .error = uiState {
            showErrorAlert = true
        }
    }
    
    func resetState() {
        uiState = .emptyList
        showErrorAlert = false
    }
}


extension HabitViewModel {
    func onAppear() {
        self.uiState = .loading
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            var rows: [HabitCardViewModel] = []
            
            rows.append(HabitCardViewModel(
                id: 1,
                icon: "pencil",
                date: "01/01/2021 00:00:00",
                name: "Tocar guitarra",
                label: "horas",
                value: "2",
                state: .green
            ))
            
            rows.append(HabitCardViewModel(
                id: 2,
                icon: "book",
                date: "02/01/2021 12:30:00",
                name: "Ler um livro",
                label: "páginas",
                value: "15",
                state: .blue
            ))
            
            rows.append(HabitCardViewModel(
                id: 3,
                icon: "flame",
                date: "03/01/2021 08:30:00",
                name: "Correr",
                label: "km",
                value: "5",
                state: .red
            ))
            
            rows.append(HabitCardViewModel(
                id: 4,
                icon: "leaf",
                date: "04/01/2021 07:00:00",
                name: "Meditar",
                label: "minutos",
                value: "20",
                state: .purple
            ))
            
            rows.append(HabitCardViewModel(
                id: 5,
                icon: "bed.double.fill",
                date: "05/01/2021 22:00:00",
                name: "Dormir cedo",
                label: "horas",
                value: "8",
                state: .orange
            ))
            
            self.uiState = .fullList(rows)
        }
    }
}
