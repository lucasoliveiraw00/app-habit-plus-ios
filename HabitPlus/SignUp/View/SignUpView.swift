//
//  SignUpView.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 20/10/24.
//

import SwiftUI
import Combine

struct SignUpView: View {
    
    @ObservedObject var viewModel: SignUpViewModel
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Cadastro")
                            .foregroundColor(.black)
                            .font(Font.system(.title).bold())
                            .padding(.bottom, 8)
                        
                        fullNameField
                        
                        emailField
                        
                        passwordField
                        
                        documentField
                        
                        phoneField
                        
                        birthdayField
                        
                        genderField
                        
                        enterButton
                        
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 8)
            }
            .padding()
            
            if case SignUpUIState.error(let error) = viewModel.uiState {
                Text("").alert(isPresented: .constant(true)) {
                    Alert(title: Text("Habit Plus"), message: Text(error), dismissButton: .default(Text("Ok")) {
                        
                    })
                }
            }
        }
    }
}

extension SignUpView {
    var fullNameField: some View {
        EditTextView(
            text: $viewModel.fullName,
            placeholder: "Nome completo",
            error: "Preencher nome completo",
            enableFailure: fullNameIsInvalid(),
            autocapitalization: .words
        )
    }
    
    private func fullNameIsInvalid() -> Bool {
        return viewModel.fullName.count < 5
    }
}

extension SignUpView {
    var emailField: some View {
        EditTextView(
            text: $viewModel.email,
            placeholder: "E-mail",
            keyboard: .emailAddress,
            error: "E-mail inválido",
            enableFailure: emailIsValid()
        )
    }
    
    private func emailIsValid() -> Bool {
        return !viewModel.email.isEmail()
    }
}

extension SignUpView {
    var passwordField: some View {
        EditTextView(
            text: $viewModel.password,
            placeholder: "Senha",
            keyboard: .default,
            enableSecure: true,
            error: "Senha inválida",
            enableFailure: passwordIsInvalid()
        )
    }
    
    private func passwordIsInvalid() -> Bool {
        return viewModel.password.count <= 5
    }
}

extension SignUpView {
    var documentField: some View {
        EditTextView(
            text: $viewModel.document,
            placeholder: "CPF",
            mask: "###.###.###-##",
            keyboard: .numberPad,
            error: "CPF inválido",
            enableFailure: documentIsInvalid()
        )
    }
    
    private func documentIsInvalid() -> Bool {
        return viewModel.document.count != 14
    }
}

extension SignUpView {
    var phoneField: some View {
        EditTextView(
            text: $viewModel.phone,
            placeholder: "Celular",
            mask: "(##) ####-####",
            keyboard: .numberPad,
            error: "Celular inválido",
            enableFailure: phoneIsInvalid()
        )
    }
    
    private func phoneIsInvalid() -> Bool {
        return viewModel.phone.count < 14 || viewModel.phone.count > 15
    }
}

extension SignUpView {
    var birthdayField: some View {
        EditTextView(
            text: $viewModel.birthday,
            placeholder: "Data de nascimento",
            mask: "##/##/####",
            keyboard: .numberPad,
            error: "Data inválida",
            enableFailure: birthdayIsInvalid()
        )
    }
    
    private func birthdayIsInvalid() -> Bool {
        return viewModel.birthday.count != 10
    }
}

extension SignUpView {
    var genderField: some View {
        Picker("Gender", selection: $viewModel.gender) {
            ForEach(Gender.allCases, id: \.self) { value in
                Text(value.rawValue).tag(value)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(.top, 16)
        .padding(.bottom, 32)
    }
}

extension SignUpView {
    var enterButton: some View {
        CustomButton(
            text: "Realize seu Cadastro",
            action: {
                viewModel.signUp()
            },
            isLoading: viewModel.uiState == SignUpUIState.loading,
            disabled: isFormInvalid()
        )
        .padding(.top, 8)
    }
    
    private func isFormInvalid() -> Bool {
        return fullNameIsInvalid() ||
        emailIsValid() ||
        passwordIsInvalid() ||
        documentIsInvalid() ||
        phoneIsInvalid() ||
        birthdayIsInvalid()
    }
}
#Preview {
    SignUpView(
        viewModel: SignUpViewModel(
            interactor: SignUpInteractor(),
            goToHomePublisher: PassthroughSubject(),
            resetAuthPublisher: PassthroughSubject()
        )
    )
}
