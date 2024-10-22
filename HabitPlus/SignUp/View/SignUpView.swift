//
//  SignUpView.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 20/10/24.
//

import SwiftUI

struct SignUpView: View {
    
    @ObservedObject var viewModel: SignUpViewModel
    
    @State var fullName = ""
    @State var email = ""
    @State var document = ""
    @State var phone = ""
    @State var birthday = ""
    @State var gender =  Gender.male
    
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
        TextField("", text: $fullName)
            .frame(height: 26)
            .background(Color.white)
            .border(Color.orange)
        
    }
}


extension SignUpView {
    var emailField: some View {
        TextField("", text: $email)
            .frame(height: 26)
            .background(Color.white)
            .border(Color.orange)
        
    }
}


extension SignUpView {
    var documentField: some View {
        TextField("", text: $document)
            .frame(height: 26)
            .background(Color.white)
            .border(Color.orange)
        
    }
}

extension SignUpView {
    var phoneField: some View {
        TextField("", text: $phone)
            .frame(height: 26)
            .background(Color.white)
            .border(Color.orange)
        
    }
}

extension SignUpView {
    var birthdayField: some View {
        TextField("", text: $birthday)
            .frame(height: 26)
            .background(Color.white)
            .border(Color.orange)
        
    }
}

extension SignUpView {
    var genderField: some View {
        Picker("Gender", selection: $gender) {
            ForEach(Gender.allCases, id: \.self) { value in
                Text(value.rawValue).tag(value)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(.top, 16)
        .padding(.bottom,32)
        
    }
}


extension SignUpView {
    var enterButton: some View {
        Button("Realize seu Cadastro") {
            viewModel.home()
        }
        .padding(.top, 8)
    }
}

#Preview {
    SignUpView(viewModel: SignUpViewModel())
}
