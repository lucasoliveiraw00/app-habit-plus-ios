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
    private let local: LocalDataSource = .shared
    
}

extension ProfileInteractor {
    func fetchUser() -> Future<ProfileResponse, AppError> {
        return remote.fetchUser()
    }
    
    func updateUser(userId: Int, profileRequest: ProfileRequest) -> Future<ProfileResponse, AppError> {
        return remote.updateUser(userId: userId, request: profileRequest)
    }
    
    func removeUserAuth(){
        local.removeUserAuth()
    }
}
