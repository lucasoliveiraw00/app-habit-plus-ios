//
//  SignInInteractor.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 29/10/24.
//

import Foundation
import Combine

class SignInInteractor {
    
    private let remote: SignInRemoteDataSource = .shared
 
}

extension SignInInteractor {
    func login(
        request: SignInRequest
    ) -> Future<SignInResponse, AppError> {
       return remote.login(request: request)
    }
}
