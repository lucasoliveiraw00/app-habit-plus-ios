//
//  HabitInteractor.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 18/11/24.
//

import Foundation
import Combine

class HabitInteractor {
    
    private let remote: HabitRemoteDataSource = .shared
 
}

extension HabitInteractor {
    func fetchHabits() -> Future<[HabitResponse], AppError> {
       return remote.fetchHabits()
    }
    
}
