//
//  AuthViewModel.swift
//  FlexSub
//
//  Created by Theo Marie on 24/10/2024.
//

import SwiftUI
import FirebaseAuth

@Observable class AuthViewModel {
    var isLoggedIn: Bool = false
    var isLoading: Bool = true
    var errorMessage: String = ""
    
    init() {
        checkIfUserIsLoggedIn()
    }
    
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser != nil {
            // Utilisateur connecté
            self.isLoggedIn = true
        } else {
            // Pas de session active
            self.isLoggedIn = false
        }
        self.isLoading = false
    }
    
    func login(email: String, password: String) {
        AuthManager.shared.loginUser(email: email, password: password) { result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.isLoggedIn = true // L'utilisateur est maintenant connecté
                    self.errorMessage = ""
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func register(email: String, password: String) {
        AuthManager.shared.registerUser(email: email, password: password) { result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.isLoggedIn = true // Inscription réussie
                    self.errorMessage = ""
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            DispatchQueue.main.async {
                self.isLoggedIn = false // L'utilisateur est maintenant déconnecté
            }
        } catch let error {
            DispatchQueue.main.async {
                self.errorMessage = "Erreur lors de la déconnexion : \(error.localizedDescription)"
            }
        }
    }
}
