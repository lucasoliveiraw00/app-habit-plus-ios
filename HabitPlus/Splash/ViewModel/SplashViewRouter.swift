//
//  SplashViewRouter.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 19/10/24.
//

import SwiftUI
import Combine

enum SplashViewRouter {
    static func makeSignInView(resetAuthPublisher: PassthroughSubject<Bool, Never>) -> some View {
        return SignInView(
            viewModel: SignInViewModel(
                interactor: SignInInteractor(),
                homeViewModel: HomeViewModel(resetAuthPublisher: resetAuthPublisher)
            )
        )
    }
    
    static func makeHomeView(resetAuthPublisher: PassthroughSubject<Bool, Never>) -> some View {
        return HomeView(
            viewModel: HomeViewModel(resetAuthPublisher: resetAuthPublisher)
        )
    }
}
