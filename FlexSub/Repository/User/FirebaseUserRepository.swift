//
//  UserRepository.swift
//  FlexSub
//
//  Created by Theo Marie on 04/11/2024.
//


// FirebaseUserRepository.swift
import Foundation
import FirebaseFirestore

class FirebaseUserRepository {
    private let db = Firestore.firestore()
    private let requestManager = RequestManager.shared
    private let usersCollection = "users"
    
    func fetchUserById(id: String) async -> RequestState<User> {
           return await RequestManager.shared.perform {
               let db = Firestore.firestore()
               let document = try await db.collection("users").document(id).getDocument()
               
               guard let data = document.data() else {
                   throw FirebaseError.noDocuments
               }
               
               guard
                   let username = data["username"] as? String,
                   let email = data["email"] as? String,
                   let firstName = data["firstName"] as? String,
                   let lastName = data["lastName"] as? String,
                   let address = data["address"] as? String
               else {
                   throw FirebaseError.decodingError
               }
               
               let profileImageUrl = data["profileImageUrl"] as? String
               return User(id: id, username: username, email: email, firstName: firstName, lastName: lastName, profileImageUrl: profileImageUrl, address: address)
           }
       }
}
