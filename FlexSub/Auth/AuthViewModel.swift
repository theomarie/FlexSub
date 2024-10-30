//
//  AuthViewModel.swift
//  FlexSub
//
//  Created by Theo Marie on 24/10/2024.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

@Observable class AuthViewModel {
    var isLoggedIn: Bool = false
    var isLoading: Bool = true
    var currentUser: User?
    var errorMessage: String = ""
    private var imageCache: [String: UIImage] = [:] // Cache pour les images

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
    
   
    func registerUser(_ user: User, profileImage: UIImage?) async -> RequestState<User> {
            isLoading = true
            defer { isLoading = false }

            return await RequestManager.shared.perform {
                // 1. Créer l'utilisateur dans Firebase Auth
                let authResult = try await Auth.auth().createUser(withEmail: user.email, password: user.password)
                user.id = authResult.user.uid
                
                // 2. Upload de l'image si elle existe et mettre à jour UserImage
                let imageUrl = try await StorageManager.shared.uploadProfileImage(profileImage, userId: user.id)
                if let image = profileImage {
                    self.imageCache[user.id] = image // Mettre en cache l'image
                }
                user.userImage = UserImage(image: profileImage, url: imageUrl)
                
                // 3. Sauvegarder dans Firestore
                let userData: [String: Any] = [
                    "id": user.id,
                    "username": user.username,
                    "email": user.email,
                    "firstName": user.firstName,
                    "lastName": user.lastName,
                    "address": user.address ?? "",
                    "profileImageUrl": user.userImage.url ?? UserImage.defaultUrl
                ]
                
                try await Firestore.firestore()
                    .collection("users")
                    .document(user.id)
                    .setData(userData)
                
                self.isLoggedIn = true
                self.currentUser = user
                
                return user // Retourner l'utilisateur en cas de succès
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
