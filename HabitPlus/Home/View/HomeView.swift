//
//  HomeView.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 20/10/24.
//

import SwiftUI
import Combine

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    @State var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            viewModel.habitView().tabItem {
                Image(systemName: "square.grid.2x2" )
                Text("Hábitos")
            }.tag(1)
            viewModel.habitForChartView().tabItem {
                Image(systemName: "chart.bar" )
                Text("Gráficos")
            }.tag(2)
            viewModel.profileView().tabItem {
                Image(systemName: "person.crop.circle" )
                Text("Perfil")
            }.tag(3)
        }
        .background(Color.white)
        .accentColor(Color.orange)
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel(resetAuthPublisher: PassthroughSubject()))
}
