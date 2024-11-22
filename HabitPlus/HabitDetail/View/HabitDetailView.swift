//
//  HabitDetailView.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 21/11/24.
//

import SwiftUI

struct HabitDetailView: View {
    
    @ObservedObject var viewModel: HabitDetailViewModel
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    init(viewModel: HabitDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .center, spacing: 12) {
                Text(viewModel.name)
                    .foregroundColor(Color.orange)
                    .font(.title.bold())

                Text("Unidade: \(viewModel.label)")

                VStack {
                    TextField("Escreva aqui o valor conquistado", text: $viewModel.value)
                        .multilineTextAlignment(.center)
                        .textFieldStyle(PlainTextFieldStyle())
                        .keyboardType(.numberPad)
                }

                Divider()
                    .frame(height: 1)
                    .background(Color.gray)
                    .padding(.horizontal, 32)

                Text("Os registros devem ser feitos em até 24h.\nHábitos se constroem todos os dias :)")

                CustomButton(
                    text: "Salvar",
                    action: {
                        viewModel.save()
                    },
                    isLoading: self.viewModel.uiState == .loading,
                    disabled: self.viewModel.value.isEmpty
                )
                .padding(.horizontal, 16)
                .padding(.vertical, 8)

                Button("Cancelar") {
                    self.presentationMode.wrappedValue.dismiss()
                }
                .modifier(ButtonStyles())
                .padding(.horizontal, 16)

                Spacer()
                    .padding(.horizontal, 8)
                    .padding(.top, 32)
            }
        }
    }
}

#Preview {
    HabitDetailView(viewModel: HabitDetailViewModel(
        id: 1,
        name: "Tocar guiterra",
        label: "horas",
        interactor: HabitDetailInteractor()
        )
    )
}
