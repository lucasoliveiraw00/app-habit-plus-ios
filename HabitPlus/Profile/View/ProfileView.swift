//
//  ProfileView.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 23/11/24.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        ZStack {
            if case ProfileUIState.loading = viewModel.uiState {
                ProgressView()
            } else {
                NavigationView {
                    VStack {
                        Form {
                            Section(header: Text("Dados cadastrais")) {
                                HStack {
                                    Text("Nome")
                                    Spacer()
                                    TextField("Digite o nome", text: $viewModel.fullNameValidation.value)
                                        .keyboardType(.alphabet)
                                        .multilineTextAlignment(.trailing)
                                }
                                
                                if viewModel.fullNameValidation.failure {
                                    Text("O nome deve ter pelo menos 3 caracteres.")
                                        .foregroundColor(.red)
                                        .font(.caption)
                                }
                                
                                HStack {
                                    Text("E-mail")
                                    Spacer()
                                    TextField("", text: $viewModel.email)
                                        .disabled(true)
                                        .foregroundColor(Color.gray)
                                        .multilineTextAlignment(.trailing)
                                }
                                
                                HStack {
                                    Text("CPF")
                                    Spacer()
                                    TextField("", text: $viewModel.document)
                                        .disabled(true)
                                        .foregroundColor(Color.gray)
                                        .multilineTextAlignment(.trailing)
                                }
                                
                                HStack {
                                    Text("Celular")
                                    Spacer()
                                    TextField("Digite o seu celular", text: $viewModel.phoneValidation.value)
                                        .keyboardType(.numberPad)
                                        .multilineTextAlignment(.trailing)
                                }
                                
                                if viewModel.phoneValidation.failure {
                                    Text("O número de telefone deve ter entre 10 e 11 dígitos.")
                                        .foregroundColor(.red)
                                        .font(.caption)
                                }
                                
                                HStack {
                                    Text("Data de nascimento")
                                    Spacer()
                                    TextField("Digite a sua data de nascimento", text: $viewModel.birthdayValidation.value)
                                        .multilineTextAlignment(.trailing)
                                }
                                
                                if viewModel.birthdayValidation.failure {
                                    Text("A data deve estar no formato DD/MM/AAAA.")
                                        .foregroundColor(.red)
                                        .font(.caption)
                                }
                                
                                NavigationLink(
                                    destination: GenderSelectorView(
                                        selectedGender: $viewModel.gender,
                                        genders: Gender.allCases,
                                        title: "Escolha o gênero"
                                    ),
                                    label: {
                                        HStack {
                                            Text("Gênero")
                                            Spacer()
                                            Text(viewModel.gender?.rawValue ?? "")
                                        }
                                    }
                                )
                            }
                        }
                        .navigationBarTitle(Text("Editar Perfil"), displayMode: .automatic)
                        .navigationBarItems(
                            trailing:
                                Button(
                                    action: {
                                        viewModel.updateUser()
                                    },
                                    label: {
                                        if case ProfileUIState.updateLoading = viewModel.uiState {
                                            ProgressView()
                                        } else {
                                            Image(systemName: "checkmark")
                                                .foregroundColor(.orange)
                                        }
                                    }
                                )
                                .alert(isPresented: .constant(viewModel.uiState == .updateSuccess)) {
                                    Alert(
                                        title: Text("Habit"),
                                        message: Text("Dados atualizados com sucesso"),
                                        dismissButton: .default(Text("Ok")) {
                                            viewModel.uiState = .none
                                        }
                                    )
                                }
                                .disabled(viewModel.disabledDone)
                                .opacity(viewModel.disabledDone ? 0 : 1)
                        )
                    }
                }
            }
            
            if case ProfileUIState.updateError(let value) = viewModel.uiState {
                Text("")
                    .alert(isPresented: .constant(true)) {
                        Alert(
                            title: Text("Habit"),
                            message: Text(value),
                            dismissButton: .default(Text("Ok")) {
                                viewModel.uiState = .none
                            }
                        )
                    }
            }
            
            if case ProfileUIState.fetchError(let value) = viewModel.uiState {
                Text("")
                    .alert(isPresented: .constant(true)) {
                        Alert(
                            title: Text("Habit"),
                            message: Text(value),
                            dismissButton: .default(Text("Ok"))
                        )
                    }
            }
        }
        .onAppear(perform: viewModel.fetchUser)
    }
}


#Preview {
    ProfileView(viewModel: ProfileViewModel(interactor: ProfileInteractor()))
}
