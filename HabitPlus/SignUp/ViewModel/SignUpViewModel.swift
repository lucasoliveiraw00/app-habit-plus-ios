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
        
        WebService.postUser(
            request: SignUpRequest(
                fullName: fullName,
                email: email,
                password: password,
                document: document,
                phone: phone,
                birthday: birthday,
                gender: gender.index
            )
        ) {successResponse, errorResponse in
            if let error = errorResponse {
                DispatchQueue.main.async {
                    self.uiState = .error(error.detail)
                }
            }
            if let success = successResponse {
                WebService.login(
                    request: SignInRequest(
                        email: self.email,
                        password: self.password
                    )
                ) { successResponse, errorResponse in
                    if let error = errorResponse {
                        DispatchQueue.main.async {
                            self.uiState = .error(error.detail.message)
                        }
                    }
                    if successResponse != nil {
                        DispatchQueue.main.async {
                            self.uiState = .success
                            self.publisher?.send(success)
                        }
                    }
                }
            }
        }
    }
}


extension SignUpViewModel {
    func homeView() -> some View {
        return SignUpViewRouter.makeHomeView()
    }
}

