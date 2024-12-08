//
//  HomeViewModel.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 20/10/24.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    
    let habitViewModel: HabitViewModel
    let chartViewModel: HabitViewModel
    let viewModelProfile: ProfileViewModel
    let resetAuthPublisher: PassthroughSubject<Bool, Never>
    
    init(resetAuthPublisher: PassthroughSubject<Bool, Never>) {
        self.resetAuthPublisher = resetAuthPublisher
        
        self.habitViewModel = HabitViewModel(isChart: false, interactor: HabitInteractor())
        self.chartViewModel = HabitViewModel(isChart: true, interactor: HabitInteractor())
        self.viewModelProfile = ProfileViewModel(
            interactor: ProfileInteractor(),
            resetAuthPublisher: resetAuthPublisher
        )
    }
    
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
