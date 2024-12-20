//
//  HabitCardView.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 13/11/24.
//

import SwiftUI
import Combine

struct HabitCardView: View {
    
    @State private var action = false
    
    let viewModel: HabitCardViewModel
    
    let isChart: Bool
    
    var body: some View {
        ZStack(alignment: .trailing) {
            navigationButton
            habitButton
        }
    }
}

extension HabitCardView {
    var navigationButton: some View {
        Group{
            if isChart {
                NavigationLink(destination: viewModel.chartView(), isActive: self.$action) {
                    EmptyView()
                }
            } else {
                NavigationLink(destination: viewModel.habitDetailView(), isActive: self.$action) {
                    EmptyView()
                }
            }
        }
    }
}

extension HabitCardView {
    var habitButton: some View {
        Button(action: {
            self.action = true
        }) {
            HStack(spacing: 12) {
                iconView
                detailsView
                Spacer()
                recordedView
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.orange, lineWidth: 1.4)
                    .shadow(color: .gray.opacity(0.3), radius: 4, x: 2, y: 2)
            )
            .overlay(statusIndicator, alignment: .trailing)
            .cornerRadius(8)
        }
        .cornerRadius(8)
        .padding(.vertical, 4)
    }
}

extension HabitCardView {
    var iconView: some View {
        ImageView(url: viewModel.icon)
            .aspectRatio(contentMode: .fill )
            .frame(width: 32, height: 32)
            .clipped()
    }
}

extension HabitCardView {
    var detailsView: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(viewModel.name)
                .font(.headline)
                .foregroundColor(Color.orange)
            
            Text(viewModel.label)
                .font(.subheadline)
                .foregroundColor(Color("textColor"))
            
            Text(viewModel.date)
                .font(.caption)
                .foregroundColor(Color("textColor"))
                .multilineTextAlignment(.leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

extension HabitCardView {
    var recordedView: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Registrado")
                .font(.subheadline)
                .foregroundColor(Color.orange)
                .bold()
            
            Text(viewModel.value)
                .font(.title3)
                .foregroundColor(Color("textColor"))
                .bold()
        }
        .padding(.trailing, 8)
    }
}

extension HabitCardView {
    var statusIndicator: some View {
        Rectangle()
            .frame(width: 8)
            .foregroundColor(viewModel.state)
            .opacity(!isChart ? 1 : 0)
            .cornerRadius(8, corners: [.topRight, .bottomRight])
    }
}

#Preview {
    NavigationView {
        List {
            HabitCardView(
                viewModel: HabitCardViewModel(
                    id: 1,
                    icon: "pencil",
                    date: "01/01/2021 00:00:00",
                    name: "Tocar guitarra",
                    label: "horas",
                    value: "2",
                    state: .green,
                    habitPublisher: PassthroughSubject<Bool, Never>()
                ),
                isChart: false
            )
            
            HabitCardView(
                viewModel: HabitCardViewModel(
                    id: 2,
                    icon: "pencil",
                    date: "02/01/2021 00:00:00",
                    name: "Ler um livro",
                    label: "páginas",
                    value: "10",
                    state: .blue,
                    habitPublisher: PassthroughSubject<Bool, Never>()
                ),
                isChart: true
            )
        }
        .listStyle(PlainListStyle())
        .frame(maxWidth: .infinity)
        .navigationTitle("Hábitos")
    }
}
