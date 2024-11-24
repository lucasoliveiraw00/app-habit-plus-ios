//
//  HomeViewModel.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 20/10/24.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    
    let habitViewModel = HabitViewModel(isChart: false, interactor: HabitInteractor())
    let chartViewModel = HabitViewModel(isChart: true, interactor: HabitInteractor())
    let viewModelProfile = ProfileViewModel(interactor: ProfileInteractor())
}

extension HomeViewModel {
    func habitView() -> some View {
        return HomeViewRouter.makeHabitView(viewModel: habitViewModel)
    }
    func habitForChartView() -> some View {
        return HomeViewRouter.makeHabitView(viewModel: chartViewModel)
    }
    func profileView() -> some View {
        return HomeViewRouter.makeProfileView(viewModel: viewModelProfile)
    }
}
