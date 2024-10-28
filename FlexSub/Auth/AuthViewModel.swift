//
//  AuthViewModel.swift
//  FlexSub
//
//  Created by Theo Marie on 24/10/2024.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore


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
    
   
    func register(email: String, password: String, additionalUserData: [String: Any] = [:]) {
        AuthManager.shared.registerUser(email: email, password: password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let authResult):
                    self.isLoggedIn = true // Inscription réussie
                    self.errorMessage = ""
                    print("Utilisateur enregistré avec succès : \(authResult.user.email ?? "Email inconnu")")
                    self.saveUserDataToFirestore(uid: authResult.user.uid, email: email, additionalUserData: additionalUserData)

                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    print("Erreur lors de l'enregistrement : \(error.localizedDescription)")  // Ajoute cette ligne pour le débogage
                }
            }
        }
    }
    
    private func saveUserDataToFirestore(uid: String, email: String, additionalUserData: [String: Any]) {
           var userData: [String: Any] = [
               "email": email,
               "uid": uid,
               "createdAt": Timestamp()
           ]
           
           // Fusionner les données supplémentaires si présentes
           userData.merge(additionalUserData) { (_, new) in new }
           print("dans firestore")
           Firestore.firestore().collection("users").document(uid).setData(userData) { error in
               DispatchQueue.main.async {
                   if let error = error {
                       self.errorMessage = "Erreur lors de la sauvegarde des données utilisateur : \(error.localizedDescription)"
                   } else {
                       print("Les données de l'utilisateur ont été enregistrées avec succès dans Firestore.")
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
