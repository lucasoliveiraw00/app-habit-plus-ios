//
//  HabitViewRouter.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 23/11/24.
//

import Foundation
import Combine
import SwiftUI

enum HabitViewRouter {
    static func makeHabitCreateView(habitPublisher: PassthroughSubject<Bool, Never>) -> some View {
        let viewModel = HabitCreateViewModel(interactor: HabitCreateInteractor())
        viewModel.habitPublisher = habitPublisher
        return HabitCreateView(viewModel: viewModel)
    }
}
