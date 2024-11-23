//
//  HomeViewRouter.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 12/11/24.
//

import Foundation
import SwiftUI

enum HomeViewRouter {
    static func makeHabitView(viewModel: HabitViewModel) -> some View {
        return HabitView(viewModel: viewModel)
    }
}
