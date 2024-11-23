//
//  ProfileViewModel.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 23/11/24.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var fullNameValidation = FullNameValidation()
    @Published var phoneValidation = PhoneValidation()
    @Published var birthdayValidation = BirthdayValidation()
    
    @Published var email: String = "joao.silva@email.com"
    @Published var cpf: String = "123.456.789-00"
    @Published var selectedGender: Gender? = .male
    
    var disabledDone: Bool {
        fullNameValidation.failure
        || phoneValidation.failure
        || birthdayValidation.failure
    }
}

class FullNameValidation: ObservableObject {
    @Published var failure = false

    var value: String = "" {
        didSet {
            failure = value.count < 3
        }
    }
}

class PhoneValidation: ObservableObject {
    @Published var failure = false

    var value: String = "" {
        didSet {
            failure = value.count < 10 || value.count >= 12
        }
    }
}

class BirthdayValidation: ObservableObject {
    @Published var failure = false

    var value: String = "" {
        didSet {
            failure = value.count != 10
        }
    }
}
