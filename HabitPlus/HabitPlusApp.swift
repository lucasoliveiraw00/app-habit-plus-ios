//
//  HabitPlusApp.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 19/10/24.
//

import SwiftUI

@main
struct HabitPlusApp: App {
    var body: some Scene {
        WindowGroup {
            SplashView(viewModel: SplashViewModel(interactor: SplashInteractor()))
        }
    }
}
