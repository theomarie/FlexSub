//
//  user.swift
//  FlexSub
//
//  Created by Theo Marie on 23/10/2024.
//


import SwiftUI
import FirebaseFirestore


class User: Identifiable, ObservableObject, Equatable {
   
    var id: String
    public let isCurrentUser: Bool = false
    var username: String
    var email: String
    var firstName: String
    var lastName: String
    var profileImageUrl: String? = "gs://flexsub-edf76.appspot.com/profile_images/fdsfsfe874894894894.jpg"
    var address: String
    var picture: UIImage?
    var reviews: [Review] = []  // Liste des avis pour cet utilisateur
  //  var phone: String? voir peut etre un protocol pour la gestion des numéros

    var userImage: UserImage {
           get {
               UserImage(url: profileImageUrl)
           }
           set {
               profileImageUrl = newValue.url
           }
       }
    
    static func fetchUserById(id: String) async -> RequestState<User> {
           // Utilisation de RequestManager pour gérer l'état de la requête
           return await RequestManager.shared.perform {
               let db = Firestore.firestore()
               let document = try await db.collection("users").document(id).getDocument()
               print(document.data())
               guard let data = document.data() else {
                   throw FirebaseError.noDocuments
               }
               
               // Récupération et mappage des champs du document Firestore
               guard
                   let username = data["username"] as? String,
                   let email = data["email"] as? String,
                   let firstName = data["firstName"] as? String,
                   let lastName = data["lastName"] as? String,
                   let address = data["address"] as? String
               else {
                   throw FirebaseError.decodingError
               }
               
               print("verif is " + username)
               let profileImageUrl = data["profileImageUrl"] as? String
               return User(id: id, username: username, email: email, firstName: firstName, lastName: lastName, profileImageUrl: profileImageUrl, address: address)
           }
       }
    static func == (lhs: User, rhs: User) -> Bool {
            return lhs.id == rhs.id // Compare les identifiants uniques
            // Et/ou d'autres propriétés importantes pour l'égalité
        }
    
    
    static func sampleData() -> [User] {
           return [
            /*
            User(id:  UUID().uuidString, username: "john_doe", email: "john.doe@example.com",  firstName: "John", lastName: "Doe", profileImageUrl: "", address: "123 Main St, Paris, France"),
            User(id:  UUID().uuidString, username: "jane_smith", email: "jane.smith@example.com",  firstName: "Jane", lastName: "Smith", profileImageUrl: "", address: "456 Elm St, Lyon, France"),
            User(id:  UUID().uuidString, username: "mike_jones", email: "mike.jones@example.com",  firstName: "Mike", lastName: "Jones", profileImageUrl: "", address: "789 Oak St, Bordeaux, France"),
            User(id:  UUID().uuidString, username: "emma_williams", email: "emma.williams@example.com",  firstName: "Emma", lastName: "Williams", profileImageUrl: "", address: "321 Maple St, Lille, France"),
            User(id:  UUID().uuidString, username: "lucas_brown", email: "lucas.brown@example.com",  firstName: "Lucas", lastName: "Brown", profileImageUrl: "", address: "654 Pine St, Nice, France")
             */
           ]
       }
    
    init(id: String, username: String, email: String, firstName: String, lastName: String, profileImageUrl: String?, address: String) {
        self.id = id
        self.username = username
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.profileImageUrl = profileImageUrl
        self.address = address
    }
    
    
    
    enum CodingKeys: String, CodingKey {
        case username
        case email
        case password
        case firstName
        case lastName
        case address
        case profileImageUrl
        
    }
    
    
}


