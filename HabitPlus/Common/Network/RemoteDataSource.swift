//
//  RemoteDataSource.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 29/10/24.
//

import Foundation
import Combine

class RemoteDataSource {
    
    static var shared: RemoteDataSource = RemoteDataSource()
    
    private init() {
        
    }
    
    func login(
        request: SignInRequest
    ) -> Future<SignInResponse, AppError> {
        return Future<SignInResponse, AppError> { promise in
            WebService.call(
                path: .login,
                params: [
                    URLQueryItem(name: "username", value: request.email),
                    URLQueryItem(name: "password", value: request.password)
                ]
            ) { result in
                switch result {
                case .failure(let error, let data):
                    if let data = data {
                        if error == .unauthorized {
                            let decoder = JSONDecoder()
                            let response = try? decoder.decode(SignInErrorResponse.self, from: data)
                            promise(.failure(AppError.response(message: response?.detail.message ?? "Erro desconhecido")))
                        }
                    }
                    break
                case .success(let data):
                    let decoder = JSONDecoder()
                    let response = try? decoder.decode(SignInResponse.self, from: data)
                    
                    guard let response = response else {
                        print("Log: Error parser \(String(data: data, encoding: .utf8)!)")
                        return
                    }
                    
                    promise(.success(response))
                    break
                }
            }
        }
    }
}
