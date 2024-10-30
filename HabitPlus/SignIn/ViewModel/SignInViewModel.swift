//
//  SignInViewModel.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 19/10/24.
//

import SwiftUI
import Combine


class SignInViewModel: ObservableObject {
    
    @Published var uiState: SignInUIState = .none
    @Published var email = ""
    @Published var password = ""
    
    private var cancellable: AnyCancellable?
    private let publisher = PassthroughSubject<Bool, Never>()
    
    init () {
        cancellable = publisher.sink { value in
            if (value) {
                self.uiState = .goToHomeScreen
            }
        }
    }
    
    deinit {
        cancellable?.cancel()
    }
    
}

extension SignInViewModel {
    func login() {
        self.uiState = .loading
        
        WebService.login(
            request: SignInRequest(
                email: email,
                password: password
            )
        ) { successResponse, errorResponse in
            if let error = errorResponse {
                DispatchQueue.main.async {
                    self.uiState = .error(error.detail.message)
                }
            }
            if successResponse != nil {
                DispatchQueue.main.async {
                    self.publisher.send(true)
                }
            }
        }
    }
}


extension SignInViewModel {
    func homeView() -> some View {
        return SignInViewRouter.makeHomeView()
    }
    func signUpView() -> some View {
        return SignInViewRouter.makeSignUpView(publisher: self.publisher)
    }
}

