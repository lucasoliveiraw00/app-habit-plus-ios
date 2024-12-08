//
//  SignUpInteractor.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 30/10/24.
//

import Foundation
import Combine

class SignUpInteractor {
    
    private let remoteSignUp: SignUpRemoteDataSource = .shared
    private let remoteSignIn: SignInRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
    
}

extension SignUpInteractor {
    func postUser(
        request: SignUpRequest
    ) -> Future<Bool, AppError> {
        return remoteSignUp.postUser(request: request)
    }
    
    func login(
        request: SignInRequest
    ) -> Future<SignInResponse, AppError> {
        return remoteSignIn.login(request: request)
    }
    
    func insertAuth(userAuth: UserAuth){
        local.insertUserAuth(userAuth: userAuth)
    }
}
