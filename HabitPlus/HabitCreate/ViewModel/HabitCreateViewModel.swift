//
//  HabitCreateViewModel.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 23/11/24.
//

import Foundation
import SwiftUI
import Combine

class HabitCreateViewModel: ObservableObject {
    @Published var uiState: HabitCreateUIState = .none
    @Published var name: String = ""
    @Published var label: String = ""
    
    private var cancellable: AnyCancellable?
    var cancellables = Set<AnyCancellable>()
    var habitPublisher: PassthroughSubject<Bool, Never>?
    
    let interactor: HabitCreateInteractor
    
    init(interactor: HabitCreateInteractor) {
        self.interactor = interactor
    }
    
    deinit {
        cancellable?.cancel()
        for cancellable in cancellables {
            cancellable.cancel()
        }
    }
    
}

extension HabitCreateViewModel {
    func save() {
        self.uiState = .loading
    }
}
