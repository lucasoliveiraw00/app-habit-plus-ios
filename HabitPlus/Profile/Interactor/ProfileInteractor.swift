//
//  ProfileInteractor.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 23/11/24.
//

import Foundation
import Combine

class ProfileInteractor {
    
    private let remote: ProfileRemoteDataSource = .shared
    
}

extension ProfileInteractor {
    func fetchUser() -> Future<ProfileResponse, AppError> {
       return remote.fetchUser()
    }
}
