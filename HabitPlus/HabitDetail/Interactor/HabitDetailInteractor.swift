//
//  HabitDetailInteractor.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 21/11/24.
//

import Foundation
import Combine

class HabitDetailInteractor {
    private let remote: HabitDetailRemoteDataSource = .shared
}

extension HabitDetailInteractor {
    func save(habitId: Int, habitValueRequest request: HabitValueRequest) -> Future<Bool, AppError> {
        return remote.save(habitId: habitId, request: request)
    }
}
