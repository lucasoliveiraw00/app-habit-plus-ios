//
//  SignUpViewRouter.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 21/10/24.
//

import SwiftUI
import Combine

enum SignUpViewRouter {
    static func makeHomeView(resetAuthPublisher: PassthroughSubject<Bool, Never>) -> some View {
        return HomeView(viewModel: HomeViewModel(resetAuthPublisher: resetAuthPublisher))
    }
}
