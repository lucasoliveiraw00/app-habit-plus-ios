//
//  SignInView.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 19/10/24.
//

import SwiftUI

struct SignInView: View {
    
    @ObservedObject var viewModel: SignInViewModel
    
    @State var email = ""
    @State var password = ""
    @State var actionTag: Int? = 0
    @State private var path: [String] = []
    
    var body: some View {
        NavigationStack() {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .center, spacing: 20) {
                    Spacer(minLength: 48)
                    VStack(alignment: .center, spacing: 8) {
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .padding(.horizontal, 48)
                        
                        Text("Login")
                            .foregroundStyle(.orange)
                            .font(Font.system(.title).bold())
                            .padding(.top, 12)
                            .padding(.bottom, 8)
                        
                        numberField
                        
                        passwordField
                        
                        enterButton
                        
                        registerLink
                        
                        Text("Copyright @YYY")
                            .foregroundStyle(Color.gray)
                            .font(Font.system(size: 12).bold())
                            .padding(.top, 16)
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

extension SignInView {
    var numberField: some View {
        TextField("", text: $email)
            .frame(height: 26)
            .background(Color.white)
            .border(Color.orange)

    }
}

extension SignInView {
    var passwordField: some View {
        SecureField("", text: $password)
            .frame(height: 26)
            .background(Color.white)
            .border(Color.orange)
               
    }
}

extension SignInView {
    var enterButton: some View {
        Button("Entrar") {
            
        }
        .padding(.top, 8)
    }
}

extension SignInView {
    var registerLink: some View {
        VStack {
            Text("Ainda não possui um login ativo?")
                .foregroundStyle(.gray)
                .padding(.top, 48)
                .padding(.bottom, 4)
            
            NavigationLink("Realize seu Cadastro") {
                Text("Tela de Cadastro")
            }
        }
    }
}

#Preview {
    SignInView(viewModel: SignInViewModel())
}
