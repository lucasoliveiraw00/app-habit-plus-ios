//
//  LocalDataSource.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 31/10/24.
//

import Foundation
import Combine

class LocalDataSource {
    
    static var shared: LocalDataSource = LocalDataSource()
    
    private init() {
    }
    
    private func saveValue(value: UserAuth) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(value), forKey: "user_key")
    }
    
    private func readValue(forKey key: String) -> UserAuth? {
        var userAuth: UserAuth?
        if let data = UserDefaults.standard.value(forKey: key) as? Data {
            userAuth = try? PropertyListDecoder().decode(UserAuth.self, from: data)
        }
        return userAuth
    }
    
    private func removeValue(forKey key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}

extension LocalDataSource {
    
    func insertUserAuth(userAuth: UserAuth) {
        saveValue(value: userAuth)
    }
    
    func getUserAuth() -> Future<UserAuth?, Never> {
        let userAuth = readValue(forKey: "user_key")
        return Future { promise in
            promise(.success(userAuth))
        }
    }
    
    func removeUserAuth() {
        removeValue(forKey: "user_key")
    }
}
