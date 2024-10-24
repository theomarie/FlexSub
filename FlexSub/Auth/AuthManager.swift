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
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            } else if result != nil {
                self.sendEmailVerification(completion: completion)
            }
        }
    }

    private func sendEmailVerification(completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
          guard let user = Auth.auth().currentUser else {
              completion(.failure(NSError(domain: "AuthManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "Utilisateur non trouvé"])))
              return
          }
          
          user.sendEmailVerification { error in
              if let error = error {
                  completion(.failure(error))
              } else {
                  print("E-mail de vérification envoyé à \(user.email ?? "")")
                  // pas de result dans sendEmailVerification TODO avertir le user
              }
          }
      }
    
    func loginUser(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if let error = error {
                    completion(.failure(error))
                } else if result != nil {
                    print("Utilisateur connecté avec succès")
                    completion(.success(result!))
                }
            }
        }
    
    func logout(completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try Auth.auth().signOut()
            print("Utilisateur déconnecté avec succès")
            completion(.success(()))
        } catch let signOutError as NSError {
            print("Erreur lors de la déconnexion: \(signOutError)")
            completion(.failure(signOutError))
        }
    }
}
