//
//  WebService.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 28/10/24.
//

import Foundation


enum WebService {
    
    enum Endpoint: String {
        case base = "https://habitplus-api.tiagoaguiar.co"
        case postUser = "/users"
        case login = "/auth/login"
    }
    
    enum NetworkError {
        case badRequest
        case notFound
        case unauthorized
        case internalServerError
    }
    
    enum Result {
        case success(Data)
        case failure(NetworkError, Data?)
    }
    
    enum ContentType: String {
        case json = "application/json"
        case formaUrl = "application/x-www-form-urlencoded"
    }
    
    private static func completeUrl(path: Endpoint) -> URLRequest? {
        guard let url = URL(string: "\(Endpoint.base.rawValue)\(path.rawValue)") else { return nil}
        
        return URLRequest(url: url)
    }
    
    
    private static func call(
        path: Endpoint,
        contentType: ContentType,
        data: Data?,
        completion: @escaping (Result) -> Void
    ) {
        guard var urlRequest = completeUrl(path: path) else { return }
        
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "accept")
        urlRequest.setValue(contentType.rawValue, forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = data
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.internalServerError, nil))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 400:
                    completion(.failure(.badRequest, data))
                    break
                case 401:
                    completion(.failure(.unauthorized, data))
                    break
                case 200:
                    completion(.success(data))
                    break
                default:
                    break
                }
            }
        }
        
        task.resume()
    }
    
    static func call<T: Encodable>(
        path: Endpoint,
        body: T,
        completion: @escaping (Result) -> Void
    ) {
        guard let jsonData = try? JSONEncoder().encode(body) else { return }
        call(
            path: .postUser,
            contentType: .json,
            data: jsonData,
            completion: completion
        )
    }
    
    static func call(
        path: Endpoint,
        params: [URLQueryItem],
        completion: @escaping (Result) -> Void
    ) {
        guard let urlRequest = completeUrl(path: path) else { return }
        guard let absolueteURL = urlRequest.url?.absoluteString else { return }
        
        var components = URLComponents(string: absolueteURL)
        components?.queryItems = params
        
        call(
            path: .login,
            contentType: .formaUrl,
            data: components?.query?.data(using: .utf8),
            completion: completion
        )
    }
}
