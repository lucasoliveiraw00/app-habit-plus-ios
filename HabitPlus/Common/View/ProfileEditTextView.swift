//
//  ProfileEditTextView.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 24/11/24.
//

import SwiftUI

struct ProfileEditView: View {
    
    @Binding var text: String
    
    var placeholder: String = ""
    var mask: String? = nil
    var keyboard: UIKeyboardType = .default
    var autocapitalization: UITextAutocapitalizationType = .none

    var body: some View {
        VStack {
            TextField(placeholder, text: $text)
                .foregroundColor(Color("textColor"))
                .keyboardType(keyboard)
                .autocapitalization(autocapitalization)
                .multilineTextAlignment(.trailing)
                .onChange(of: text) { value in
                    if let mask = mask {
                        Mask.mask(mask: mask, value: value, text: &text)
                    }
                }
        }
    }
}

#Preview {
    VStack {
        ProfileEditView(
            text: .constant(""),
            placeholder: "Preencher nome"
        )
        .padding()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
}

