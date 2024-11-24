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
    private var cancellableLogin: AnyCancellable?
    private let publisher = PassthroughSubject<Bool, Never>()
    private let interactor: SignInInteractor
    private let homeViewModel: HomeViewModel
    
    init (interactor: SignInInteractor, homeViewModel: HomeViewModel) {
        self.interactor = interactor
        self.homeViewModel = homeViewModel
        cancellable = publisher.sink { value in
            if (value) {
                self.uiState = .goToHomeScreen
            }
        }
    }
    
    deinit {
        cancellable?.cancel()
        cancellableLogin?.cancel()
    }
    
}

extension SignInViewModel {
    func login() {
        self.uiState = .loading
        
        cancellableLogin = interactor.login(
            request: SignInRequest(
                email: email,
                password: password
            )
        )
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let appError):
                self.uiState = SignInUIState.error(appError.message)
                break
            case .finished:
                break
            }
        }, receiveValue: { success in
            self.interactor.insertAuth(
                userAuth: UserAuth(
                    acessToken: success.acessToken,
                    refreshToken: success.refreshToken,
                    expires: Date().timeIntervalSince1970 + Double(success.expires),
                    tokenType: success.tokenType
                )
            )
            self.publisher.send(true)
        })
        
    }
}


extension SignInViewModel {
    func homeView() -> some View {
        return SignInViewRouter.makeHomeView(homeViewModel: self.homeViewModel)
    }
    func signUpView() -> some View {
        return SignInViewRouter.makeSignUpView(publisher: self.publisher)
    }
}

