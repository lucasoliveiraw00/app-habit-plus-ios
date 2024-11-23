//
//  HabitView.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 12/11/24.
//

import SwiftUI

struct HabitView: View {
    
    @ObservedObject var viewModel: HabitViewModel
    
    var body: some View {
        ZStack {
            if case HabitUIState.loading = viewModel.uiState {
                progress
            } else if case HabitUIState.empytList = viewModel.uiState {
                
            } else if case HabitUIState.fullList = viewModel.uiState {
                
            } else if case HabitUIState.error = viewModel.uiState {
                
            }
        }
    }
}

extension HabitView {
    var progress: some View {
        ProgressView()
    }
}

#Preview {
    HabitView(viewModel: HabitViewModel())
}
