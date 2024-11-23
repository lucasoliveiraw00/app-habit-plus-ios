//
//  ButtonStyles.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 13/11/24.
//

import Foundation
import SwiftUI

struct ButtonStyles: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .padding(.horizontal, 16)
            .font(Font.system(.title3).bold())
            .background(Color.orange)
            .foregroundColor(.white)
            .cornerRadius(4)
    }
}
