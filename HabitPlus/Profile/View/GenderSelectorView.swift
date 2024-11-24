//
//  GenderSelectorView.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 23/11/24.
//

import SwiftUI

struct GenderSelectorView: View {
    @Binding var selectedGender: Gender?

    let genders: [Gender]
    let title: String

    var body: some View {
        Form {
            Section(header: Text(title)) {
                List(genders, id: \.id) { item in
                    HStack {
                        Text(item.rawValue)
                        Spacer()
                        Image(systemName: "checkmark")
                            .foregroundColor(selectedGender == item ? .orange : .white)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if selectedGender != item {
                            selectedGender = item
                        }
                    }
                }
            }
        }
        .navigationTitle(Text(""))
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    GenderSelectorView(selectedGender: .constant(.female), genders: Gender.allCases, title: "Gênero")
}
