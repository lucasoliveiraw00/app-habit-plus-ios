//
//  HabitCreateInteractor.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 23/11/24.
//

import Foundation
import Combine

class HabitCreateInteractor {
    private let remote: HabitCreateRemoteDataSource = .shared
}

extension HabitCreateInteractor {
    func save(habitId: Int, habitValueRequest request: HabitCreateRequest) -> Future<Bool, AppError> {
        return remote.save(habitId: habitId, request: request)
    }
}
