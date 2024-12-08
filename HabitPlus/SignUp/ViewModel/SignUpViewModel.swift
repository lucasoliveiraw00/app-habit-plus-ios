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
    @Published var fullName = ""
    @Published var email = ""
    @Published var password = ""
    @Published var document = ""
    @Published var phone = ""
    @Published var birthday = ""
    @Published var gender =  Gender.male
    
    var publisher: PassthroughSubject<Bool, Never>?
    
    private var cancellablePostUser: AnyCancellable?
    private var cancellableLogin: AnyCancellable?
    private let interactor: SignUpInteractor
    
    init (interactor: SignUpInteractor) {
        self.interactor = interactor
    }
    
    deinit {
        cancellablePostUser?.cancel()
        cancellableLogin?.cancel()
    }
    
}

extension SignUpViewModel {
    func signUp() {
        self.uiState = .loading
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd/MM/yyyy"
        
        let dateFormatter = formatter.date(from: birthday)
        
        guard let dateFormatted = dateFormatter else {
            self.uiState = .error("Data inválida \(birthday)")
            return
        }
        
        formatter.dateFormat = "yyy-MM-dd"
        let birthday = formatter.string(from: dateFormatted)
        
        cancellablePostUser = interactor.postUser(
            request: SignUpRequest(
                fullName: fullName,
                email: email,
                password: password,
                document: document,
                phone: phone,
                birthday: birthday,
                gender: gender.index
            )
        )
        .receive(on: DispatchQueue.main)
        .sink(
            receiveCompletion: { completion in
                switch completion {
                case .failure(let appError):
                    self.uiState = .error(appError.message)
                    break
                case .finished:
                    break
                }
            },
            receiveValue: { created in
                if created {
                    self.cancellableLogin = self.interactor.login(
                        request: SignInRequest(
                            email: self.email,
                            password: self.password
                        )
                    )
                    .receive(on: DispatchQueue.main)
                    .sink(
                        receiveCompletion: { completion in
                            switch completion {
                            case .failure(let appError):
                                self.uiState = .error(appError.message)
                                break
                            case .finished:
                                break
                            }
                        },
                        receiveValue: { success in
                            
                            self.interactor.insertAuth(
                                userAuth: UserAuth(
                                    acessToken: success.acessToken,
                                    refreshToken: success.refreshToken,
                                    expires: Date().timeIntervalSince1970 + Double(success.expires),
                                    tokenType: success.tokenType
                                )
                            )
                            
                            self.publisher?.send(created)
                            self.uiState = .success
                        })
                }
            })
        
    }
}


extension SignUpViewModel {
    func homeView() -> some View {
        return SignUpViewRouter.makeHomeView()
    }
}

