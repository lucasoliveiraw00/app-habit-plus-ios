//
//  CustomTextFieldStyle.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 22/10/24.
//

import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.horizontal, 8)
            .padding(.vertical, 12)
    }
}
