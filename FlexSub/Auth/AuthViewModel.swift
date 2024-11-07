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
            
            // Récupérer l'ID de l'utilisateur actuel
            
            if let userId = Auth.auth().currentUser?.uid {
                print(userId)
                Task {
                    await fetchUser(withId: userId)
                }
              
            }
            
         
        }
        
    
    func checkIfUserIsLoggedIn() {
        isLoggedIn = Auth.auth().currentUser != nil
       
            isLoading = false
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
    
   
    func registerUser(email: String, password: String, profileImage: UIImage?, user: User) async -> RequestState<User> {
            isLoading = true
            defer { isLoading = false }

            return await RequestManager.shared.perform {
                // 1. Créer l'utilisateur dans Firebase Auth
                let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
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
                    "address": user.address,
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
    
    
    
    
    func fetchUser(withId userId: String) async -> RequestState<User> {
        isLoading = true
        defer { isLoading = false }
        
        return await RequestManager.shared.perform {
            let document = try await Firestore.firestore()
                .collection("users")
                .document(userId)
                .getDocument()
            
            guard let data = document.data() else {
                throw FirebaseError.noDocuments
            }
            
            // Extraire les données utilisateur et les assigner aux propriétés
            guard let id = data["id"] as? String,
                  let email = data["email"] as? String,
                  let firstName = data["firstName"] as? String,
                  let lastName = data["lastName"] as? String,
                  let profileImageUrl = data["profileImageUrl"] as? String,
                  let username = data["username"] as? String else {
                throw FirebaseError.decodingError
            }
            
            let address = data["address"] as? String ?? ""
            
            // Créer une instance User avec les données récupérées
            let user = User(
                id: id,
                username: username,
                email: email,
                firstName: firstName,
                lastName: lastName,
                profileImageUrl: profileImageUrl,
                address: address
            )
            
            self.currentUser = user // Mettre à jour l'utilisateur actuel
            return user
        }
    }
    
    func uploadProfileImage(_ imageData: Data, userId: String) async throws -> String {
        let storageRef = Storage.storage().reference().child("profileImages/\(userId).jpg")

        // Télécharger l'image avec les métadonnées
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        _ = try await storageRef.putDataAsync(imageData, metadata: metadata)

        // Obtenir l'URL de téléchargement
        return try await storageRef.downloadURL().absoluteString
    }
}



