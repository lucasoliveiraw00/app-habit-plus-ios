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
                        
                        enterButton
                        
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 8)
            }
            .padding()
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
    var birthdayield: some View {
        TextField("", text: $birthday)
            .frame(height: 26)
            .background(Color.white)
            .border(Color.orange)
        
    }
}


extension SignUpView {
    var enterButton: some View {
        Button("Realize seu Cadastro") {
        }
        .padding(.top, 8)
    }
}

#Preview {
    SignUpView(viewModel: SignUpViewModel())
}
