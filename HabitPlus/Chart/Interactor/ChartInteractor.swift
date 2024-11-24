//
//  ChartInteractor.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 23/11/24.
//

import Foundation
import Combine

class ChartInteractor {
    private let remote: ChartRemoteDataSource = .shared
}

extension ChartInteractor {
    func fetchHabitValues(habitId: Int) -> Future<[HabitValueResponse], AppError> {
        return remote.fetchHabitValues(habitId: habitId)
    }
}
