//
//  SplashViewModel.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 19/10/24.
//

import SwiftUI


class SplashViewModel: ObservableObject {
    
    @Published var uiState: SplashUIState = .loading
    
    func onAppear() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.uiState = .goToSingInScreen
        }
    }
    
}


extension SplashViewModel {
    func signInView() -> some View {
        return SplashViewRouter.makeSignInView()
    }
}
