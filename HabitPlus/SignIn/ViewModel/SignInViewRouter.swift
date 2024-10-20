//
//  SignInViewRouter.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 20/10/24.
//

import SwiftUI

enum SignInViewRouter {
    static func makeHomeView() -> some View {
        return HomeView(viewModel: HomeViewModel())
    }
    static func makeSignUpView() -> some View {
        return SignUpView(viewModel: SignUpViewModel())
    }
}
