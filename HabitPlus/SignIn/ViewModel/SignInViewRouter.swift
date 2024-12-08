//
//  SignInViewRouter.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 20/10/24.
//

import SwiftUI
import Combine

enum SignInViewRouter {
    static func makeHomeView(homeViewModel: HomeViewModel) -> some View {
        return HomeView(viewModel: homeViewModel)
    }
    
    static func makeSignUpView(
        goToHomePublisher: PassthroughSubject<Bool, Never>,
        resetAuthPublisher: PassthroughSubject<Bool, Never>
    ) -> some View {
        let viewModel = SignUpViewModel(
            interactor: SignUpInteractor(),
            goToHomePublisher: goToHomePublisher,
            resetAuthPublisher: resetAuthPublisher
        )
        return SignUpView(viewModel: viewModel)
    }
}
