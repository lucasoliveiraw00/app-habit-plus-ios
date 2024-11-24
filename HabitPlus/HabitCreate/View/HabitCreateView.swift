//
//  HabitCreateView.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 23/11/24.
//

import SwiftUI

struct HabitCreateView: View {
    
    @ObservedObject var viewModel: HabitCreateViewModel
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    init(viewModel: HabitCreateViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .center, spacing: 12) {
                Button(action: {
                    self.viewModel.shouldPresentCamera = true
                }, label: {
                    VStack {
                        viewModel.image!
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.orange)
                        
                        Text("Clique aqui para enviar")
                            .foregroundColor(Color.orange)
                    }
                })
                .padding(.bottom, 12)
                .sheet(isPresented: self.$viewModel.shouldPresentCamera) {
                    ImagePickerView(
                        image: self.$viewModel.image,
                        imageData: self.$viewModel.imageData,
                        isPresented: self.$viewModel.shouldPresentCamera,
                        sourceType: .photoLibrary
                    )
                }
            }
            
            VStack {
                TextField("Escreva aqui o nome do hábito", text: $viewModel.name)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(PlainTextFieldStyle())
                
                Divider()
                    .frame(height: 1)
                    .background(Color.gray)
            }.padding(.horizontal, 32)
            
            VStack {
                TextField("Escreva aqui a unidade de medida", text: $viewModel.label)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(PlainTextFieldStyle())
                
                Divider()
                    .frame(height: 1)
                    .background(Color.gray)
            }.padding(.horizontal, 32)
            
            CustomButton(
                text: "Salvar",
                action: {
                    viewModel.save()
                },
                isLoading: self.viewModel.uiState == .loading,
                disabled: self.viewModel.name.isEmpty || self.viewModel.label.isEmpty
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

#Preview {
    HabitCreateView(viewModel:
                        HabitCreateViewModel(
                            interactor: HabitCreateInteractor()
                        )
    )
}
