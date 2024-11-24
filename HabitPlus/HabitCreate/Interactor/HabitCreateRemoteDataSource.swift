//
//  HabitCreateRemoteDataSource.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 23/11/24.
//

import Foundation
import Combine

class HabitCreateRemoteDataSource {
    
    static var shared: HabitCreateRemoteDataSource = HabitCreateRemoteDataSource()
    
    private init() {
    }
    
    func save(habitId: Int, request: HabitCreateRequest) -> Future<Bool, AppError> {
        return Future<Bool, AppError> { promise in
            let path = String(format: WebService.Endpoint.habitValues.rawValue, habitId)
            
            WebService.call(path: path, method: .post, body: request) { result in
                switch result {
                case .failure(_, let data):
                    if let data = data {
                        let decoder = JSONDecoder()
                        if let response = try? decoder.decode(SignInErrorResponse.self, from: data) {
                            promise(.failure(AppError.response(message: response.detail.message)))
                        } else {
                            promise(.failure(AppError.response(message: "Erro desconhecido no servidor")))
                        }
                    } else {
                        promise(.failure(AppError.response(message: "Erro desconhecido no servidor")))
                    }
                case .success(_):
                    promise(.success(true))
                }
            }
        }
    }
}