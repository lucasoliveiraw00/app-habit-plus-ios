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
    var emailField: some View {
        TextField("", text: $viewModel.email)
            .frame(height: 26)
            .background(Color.white)
            .border(Color.orange)
        
    }
}

extension SignInView {
    var passwordField: some View {
        SecureField("", text: $viewModel.password)
            .frame(height: 26)
            .background(Color.white)
            .border(Color.orange)
        
    }
}

extension SignInView {
    var enterButton: some View {
        Button("Entrar") {
            viewModel.login()
        }
        .padding(.top, 8)
    }
}

extension SignInView {
    var registerLink: some View {
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
