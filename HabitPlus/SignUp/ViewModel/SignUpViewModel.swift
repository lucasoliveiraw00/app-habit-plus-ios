//
//  SignUpViewModel.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 20/10/24.
//

import SwiftUI
import Combine

class SignUpViewModel: ObservableObject {
    
    @Published var uiState: SignUpUIState = .none
    
    var publisher: PassthroughSubject<Bool, Never>?
    
}

extension SignUpViewModel {
    func home() {
        self.uiState = .loading
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.uiState = .success
            self.publisher?.send(true)
        }
    }
}


extension SignUpViewModel {
    func homeView() -> some View {
        return SignUpViewRouter.makeHomeView()
    }
}

