//
//  SignUpViewRouter.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 21/10/24.
//

import SwiftUI


enum SignUpViewRouter {
    static func makeHomeView() -> some View {
        return HomeView(viewModel: HomeViewModel())
    }
}
