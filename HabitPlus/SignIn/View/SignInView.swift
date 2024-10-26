//
//  SignInView.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 19/10/24.
//

import SwiftUI

struct SignInView: View {
    
    @ObservedObject var viewModel: SignInViewModel
    
    var body: some View {
        ZStack {
            if case SignInUIState.goToHomeScreen = viewModel.uiState {
                viewModel.homeView()
            } else {
                NavigationView() {
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .center, spacing: 20) {
                            Spacer(minLength: 48)
                            VStack(alignment: .center, spacing: 8) {
                                Image("logo")
                                    .resizable()
                                    .scaledToFit()
                                    .padding(.horizontal, 48)
                                
                                Text("Login")
                                    .foregroundColor(.orange)
                                    .font(Font.system(.title).bold())
                                    .padding(.top, 12)
                                    .padding(.bottom, 8)
                                
                                emailField
                                
                                passwordField
                                
                                enterButton
                                
                                registerLink
                                
                                Text("Copyright @YYY")
                                    .foregroundColor(Color.gray)
                                    .font(Font.system(size: 12).bold())
                                    .padding(.top, 16)
                            }
                        }
                        
                        if case SignInUIState.error(let error) = viewModel.uiState {
                            Text("").alert(isPresented: .constant(true)) {
                                Alert(title: Text("Habit Plus"), message: Text(error), dismissButton: .default(Text("Ok")) {
                                    
                                })
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.horizontal, 32)
                    .background(Color.white)
                    .navigationTitle("Login")
                    .navigationBarHidden(true)
                }
            }
        }
    }
}

extension SignInView {
    private var emailField: some View {
        EditTextView(
            text: $viewModel.email,
            placeholder: "Peencher e-mail",
            keyboard: .emailAddress,
            error: "E-email inválido",
            enableFailure: !viewModel.email.isEmail()
        )
        
    }
}

extension SignInView {
    private var passwordField: some View {
        EditTextView(
            text: $viewModel.password,
            placeholder: "Peencher senha",
            enableSecure: true,
            error: "Senha inválida",
            enableFailure: viewModel.password.count <= 5
        )
        
    }
}

extension SignInView {
    private var enterButton: some View {
        CustomButton(text: "Entrar", action: {
            viewModel.login()
        },
                     isLoading: viewModel.uiState == SignInUIState.loading,
                     disabled: !viewModel.email.isEmail() || viewModel.password.count <= 5
        )
        .padding(.top, 12)
        .accessibilityLabel("Botão de Entrar")    }
}

extension SignInView {
    private var registerLink: some View {
        VStack {
            Text("Ainda não possui um login ativo?")
                .foregroundColor(.gray)
                .padding(.top, 48)
                .padding(.bottom, 4)
            
            ZStack {
                NavigationLink("Realize seu Cadastro") {
                    viewModel.signUpView()
                }
            }
        }
    }
}

#Preview {
    SignInView(viewModel: SignInViewModel())
}
