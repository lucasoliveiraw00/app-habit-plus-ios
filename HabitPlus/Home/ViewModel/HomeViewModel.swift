//
//  HomeViewModel.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 20/10/24.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    
    let viewModel = HabitViewModel(interactor: HabitInteractor())
    let viewModelProfile = ProfileViewModel()
}

extension HomeViewModel {
    func habitView() -> some View {
        return HomeViewRouter.makeHabitView(viewModel: viewModel)
    }
    func profileView() -> some View {
        return HomeViewRouter.makeProfileView(viewModel: viewModelProfile)
    }
}
