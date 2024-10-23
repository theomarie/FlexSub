//
//  AuthManager.swift
//  FlexSub
//
//  Created by Theo Marie on 23/10/2024.
//

import FirebaseAuth

class AuthManager {
    static let shared = AuthManager()

    private init() {}

    func registerUser(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password, completion: { result, error in
            if let error = error {
                completion(.failure(error))
            } else if let result = result {
                completion(.success(result))
            }
        })
    }
    
    
}
