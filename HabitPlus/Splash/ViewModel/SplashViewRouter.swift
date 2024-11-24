//
//  SplashViewRouter.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 19/10/24.
//

import SwiftUI

enum SplashViewRouter {
    static func makeSignInView() -> some View {
        return SignInView(viewModel: SignInViewModel(interactor: SignInInteractor(), homeViewModel: HomeViewModel()))
    }
    static func makeHomeView() -> some View {
        return HomeView(viewModel: HomeViewModel())
    }
}
