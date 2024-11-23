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
                            TextField("", text: $viewModel.cpf)
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
                                selectedGender: $viewModel.selectedGender,
                                genders: Gender.allCases,
                                title: "Escolha o gênero"
                            ),
                            label: {
                                HStack {
                                    Text("Gênero")
                                    Spacer()
                                    Text(viewModel.selectedGender?.rawValue ?? "")
                                }
                            }
                        )
                    }
                }
                .navigationBarTitle(Text("Editar Perfil"), displayMode: .automatic)
                .navigationBarItems(
                    trailing:
                        Button(
                            action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/,
                            label: {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.orange)
                            }
                        )
                        .disabled(viewModel.disabledDone)
                        .opacity(viewModel.disabledDone ? 0 : 1)
                )
            }
        }
    }
}


#Preview {
    ProfileView(viewModel: ProfileViewModel())
}
