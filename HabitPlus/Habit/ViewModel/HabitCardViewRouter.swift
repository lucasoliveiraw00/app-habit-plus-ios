//
//  HabitCardViewRouter.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 21/11/24.
//

import Foundation
import SwiftUI
import Combine

enum HabitCardViewRouter {
    static func makeHabitDetailView(id: Int, name: String, label: String, habitPublisher: PassthroughSubject<Bool, Never>) -> some View {
        let viewModel = HabitDetailViewModel(id: id, name: name, label: label, interactor: HabitDetailInteractor())
        viewModel.habitPublisher = habitPublisher
        return HabitDetailView(viewModel: viewModel)
    }
    static func makeHabitChartView(id: Int) -> some View {
        return ChartView(viewModel: ChartViewModel(habitId: id, interactor: ChartInteractor()))
    }
}
