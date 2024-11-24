//
//  ChartView.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 23/11/24.
//

import SwiftUI
import Charts

struct ChartView: View {
    
    @ObservedObject var viewModel: ChartViewModel
    
    var body: some View {
        ZStack {
            if case ChartUIState.loading = viewModel.uiState {
                ProgressView()
            } else {
                VStack {
                    if case ChartUIState.emptyChart = viewModel.uiState {
                        Image(systemName: "exclamationmark.octagon.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24, alignment: .center)
                        
                        Text("Nenhum dado encontrado :(")
                    } else if case ChartUIState.error(let msg) = viewModel.uiState {
                        Text("")
                            .alert(isPresented: .constant(true)) {
                                Alert(
                                    title: Text("Ops! \(msg)"),
                                    message: Text("Tentar novamente?"),
                                    primaryButton: .default(Text("Sim")) {
                                        viewModel.onAppear()
                                    },
                                    secondaryButton: .cancel()
                                )
                            }
                    } else {
                        BoxChartView(entries: $viewModel.entries, dates: $viewModel.dates)
                            .frame(maxWidth: .infinity, maxHeight: 350)
                    }
                }
            }
        }
        .onAppear(perform: viewModel.onAppear)
    }
    
}

#Preview {
    ChartView(viewModel: ChartViewModel(habitId: 1, interactor: ChartInteractor()))
}
