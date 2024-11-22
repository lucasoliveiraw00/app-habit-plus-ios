//
//  HabitCardViewRouter.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 21/11/24.
//

import Foundation
import SwiftUI

enum HabitCardViewRouter {
    static func makeHabitDetailView(id: Int, name: String, label: String) -> some View {
        let viewModel = HabitDetailViewModel(id: id, name: name, label: label, interactor: HabitDetailInteractor())
        return HabitDetailView(viewModel: viewModel)
    }
}
