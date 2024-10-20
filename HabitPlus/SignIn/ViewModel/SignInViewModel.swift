//
//  SignInViewModel.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 19/10/24.
//

import SwiftUI


class SignInViewModel: ObservableObject {
    
    @Published var uiState: SignInUIState = .none
    @Published var email = ""
    @Published var password = ""
    
}

extension SignInViewModel {
    func login() {
        self.uiState = .loading
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.uiState = .goToHomeScreen
        }
    }
}


extension SignInViewModel {
    func homeView() -> some View {
        return SignInViewRouter.makeHomeView()
    }
    func signUpView() -> some View {
        return SignInViewRouter.makeSignUpView()
    }
}

