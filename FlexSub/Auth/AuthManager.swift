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
                completion(.failure(error))  // En cas d’erreur d’inscription, renvoyer l'erreur
            } else if let result = result {
                self.sendEmailVerification { verifyResult in
                    switch verifyResult {
                    case .success:
                        completion(.success(result))  // Succès complet avec l'email vérifié
                    case .failure(let error):
                        completion(.failure(error))  // Si échec de vérification, retourner cette erreur
                    }
                }
            }
        }
    }

    private func sendEmailVerification(completion: @escaping (Result<Void, Error>) -> Void) {
        guard let user = Auth.auth().currentUser else {
            completion(.failure(NSError(domain: "AuthManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "Utilisateur non trouvé"])))
            return
        }
        
        user.sendEmailVerification { error in
            if let error = error {
                completion(.failure(error))
            } else {
                print("E-mail de vérification envoyé à \(user.email ?? "")")
                completion(.success(()))  // Appeler completion avec succès
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
