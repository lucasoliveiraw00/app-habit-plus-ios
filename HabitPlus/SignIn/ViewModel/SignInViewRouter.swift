//
//  SignInViewRouter.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 20/10/24.
//

import SwiftUI
import Combine

enum SignInViewRouter {
    static func makeHomeView() -> some View {
        return HomeView(viewModel: HomeViewModel())
    }
    static func makeSignUpView(publisher: PassthroughSubject<Bool, Never>) -> some View {
        let viewModel = SignUpViewModel(interactor: SignUpInteractor())
        viewModel.publisher = publisher
        return SignUpView(viewModel: viewModel)
    }
}
