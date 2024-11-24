//
//  CustomButton.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 25/10/24.
//

import SwiftUI

struct CustomButton: View {
    
    var text: String
    var action: () -> Void
    var isLoading: Bool = false
    var disabled: Bool = false
    
    var body: some View {
        ZStack {
            Button(action: {
                action()
            }, label: {
                Text(isLoading ? " " : text)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .padding(.horizontal, 16)
                    .font(Font.system(.title3).bold())
                    .background(disabled || isLoading ? Color("lightOrange") : Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(4)
            })
            .disabled(disabled || isLoading)
            
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }
            
        }
    }
}


#Preview {
    ZStack {
        CustomButton(
            text:"Entrar",
            action: {
                print("Action..")
            },
            isLoading: false,
            disabled: false
        )
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .padding()
}
