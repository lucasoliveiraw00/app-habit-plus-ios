//
//  EditTextView.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 22/10/24.
//

import SwiftUI

struct EditTextView: View {
    
    @Binding var text: String
    
    var placeholder: String = ""
    var keyboard: UIKeyboardType = .default
    var enableSecure: Bool = false
    var error: String? = nil
    var enableFailure: Bool? = nil
    var enableStartFailure: Bool = false
    var autocapitalization: UITextAutocapitalizationType = .none
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            if enableSecure {
                applyTextFieldStyle(SecureField(placeholder, text: $text))
            } else {
                applyTextFieldStyle(TextField(placeholder, text: $text))
            }
            
            alertError
            
        }
    }
    
}

extension EditTextView {
    private func applyTextFieldStyle<T: View>(_ field: T) -> some View {
        field
            .autocapitalization(autocapitalization)
            .foregroundColor(Color("textColor"))
            .keyboardType(keyboard)
            .textFieldStyle(CustomTextFieldStyle())
            .overlay(
                RoundedRectangle(cornerRadius: 8.8)
                    .stroke(borderColor(), lineWidth: 0.8)
            )
    }
}

extension EditTextView {
    private func borderColor() -> Color {
        return shouldShowError() ? Color.red : Color.orange
    }
}

extension EditTextView {
    private func shouldShowError() -> Bool {
        if let failure = enableFailure {
            return enableStartFailure ? failure : (failure && !text.isEmpty)
        }
        return false
    }
}




extension EditTextView {
    private var alertError: some View {
        Group {
            if let error = error, !error.isEmpty, shouldShowError() {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
            }
        }
    }
}



#Preview {
    VStack {
        EditTextView(
            text: .constant(""),
            placeholder: "Preencher nome",
            error: "Erro",
            enableFailure: false
        )
        .padding()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
}

