//
//  UserViewModel.swift
//  FlexSub
//
//  Created by apprenant103 on 29/10/2024.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage


//class UserViewModel: ObservableObject {
//    @Published var user: User
//
//    init() {
//        self.user = User(id: UUID().uuidString, username: "Eikichi", email: "user@example.com", password: "motdepasse", firstName: "Abdel", lastName: "Ghani", picture: nil, address: "123 Rue Principale")
//           let reviews = [
//            Review(id: UUID().uuidString, rating: 4, comment: "Super utilisateur !", date: Date()),
//            Review(id: UUID().uuidString, rating: 5, comment: "Je recommande !", date: Date())]
//        user.reviews = reviews
//    }
//}


class UserData: ObservableObject {
    @Published var user: User
    private var authStateDidChangeListenerHandle: AuthStateDidChangeListenerHandle?
    
    var firebaseUser: FirebaseAuth.User? {
        Auth.auth().currentUser
    }
    
    init() {
        let firebaseUser = Auth.auth().currentUser
        
            self.user = FlexSub.User(
                id: firebaseUser!.uid,
                username: firebaseUser!.displayName ?? "",
                email: firebaseUser!.email ?? "",
                password: "",
                firstName: "",
                lastName: "",
                picture: nil,
                address: ""
            )
        
                   
            
            //        authStateDidChangeListenerHandle = Auth.auth().addStateDidChangeListener {  auth, firebaseUser in
            //
            //
            //            if let firebaseUser = firebaseUser {
            //                self.user = FlexSub.User(
            //                    id: firebaseUser.uid,
            //                    username: firebaseUser.displayName ?? "",
            //                    email: firebaseUser.email ?? "",
            //                    password: "", // À adapter selon la gestion des mots de passe
            //                    firstName: "", // À adapter si nécessaire
            //                    lastName: "",  // À adapter si nécessaire
            //                    picture: nil,
            //                    address: ""     // À adapter si nécessaire
            //                )
            
            // Charger l'image de profil depuis Firebase Storage (si nécessaire)
            Task {
                
            }
        }
        
        
        
        
        //            if let handle = authStateDidChangeListenerHandle {
        //                Auth.auth().removeStateDidChangeListener(handle)
        //            }
        
        
        // Fonction pour charger l'image depuis Firebase Storage
        //        func loadImageFromFirebase(userId: String) async {
        //            guard let url = getProfileImageURL(userId: userId) else { return }
        
        //            do {
        //                let storage = Storage.storage()
        //                let reference = storage.reference(forURL: url.absoluteString)
        //                let data = try await reference.data(maxSize: 1 * 1024 * 1024) // 1 MB max
        //                if let uiImage = UIImage(data: data) {
        //                    user.picture = uiImage
        //                }
        //            } catch {
        //                print("Erreur lors du chargement de l'image : \(error)")
        //            }
        //        }
        
        
        func getProfileImageURL(userId: String) -> URL? {
            return nil
        }
    }
    

