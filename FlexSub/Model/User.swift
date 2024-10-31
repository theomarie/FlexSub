//
//  user.swift
//  FlexSub
//
//  Created by Theo Marie on 23/10/2024.
//


import SwiftUI

class User: Identifiable {
    var id: String
    var username: String
    var email: String
    var password: String
    var firstName: String
    var lastName: String
    var profileImageUrl: String? = ""
    var address: String
    var reviews: [Review] = []  // Liste des avis pour cet utilisateur
  //  var phone: String? voir peut etre un protocol pour la gestion des numéros
    var cachedImage: UIImage?

    var userImage: UserImage {
           get {
               UserImage(url: profileImageUrl)
           }
           set {
               profileImageUrl = newValue.url
           }
       }
    
    func loadProfileImage() async -> UIImage {
            if let cachedImage = cachedImage {
                return cachedImage
            }
            
            guard let profileImageUrl = profileImageUrl, let url = URL(string: profileImageUrl) else {
                return UserImage.defaultImage ?? UIImage()
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let image = UIImage(data: data)
                self.cachedImage = image
                return image ?? UserImage.defaultImage ?? UIImage()
            } catch {
                print("Erreur de chargement de l'image :", error.localizedDescription)
                return UserImage.defaultImage ?? UIImage()
            }
        }
    
    static func sampleData() -> [User] {
           return [
            User(id:  UUID().uuidString, username: "john_doe", email: "john.doe@example.com", password: "password123", firstName: "John", lastName: "Doe", profileImageUrl: "", address: "123 Main St, Paris, France"),
            User(id:  UUID().uuidString, username: "jane_smith", email: "jane.smith@example.com", password: "password123", firstName: "Jane", lastName: "Smith", profileImageUrl: "", address: "456 Elm St, Lyon, France"),
            User(id:  UUID().uuidString, username: "mike_jones", email: "mike.jones@example.com", password: "password123", firstName: "Mike", lastName: "Jones", profileImageUrl: "", address: "789 Oak St, Bordeaux, France"),
            User(id:  UUID().uuidString, username: "emma_williams", email: "emma.williams@example.com", password: "password123", firstName: "Emma", lastName: "Williams", profileImageUrl: "", address: "321 Maple St, Lille, France"),
            User(id:  UUID().uuidString, username: "lucas_brown", email: "lucas.brown@example.com", password: "password123", firstName: "Lucas", lastName: "Brown", profileImageUrl: "", address: "654 Pine St, Nice, France")
           ]
       }
    
    init(id: String, username: String, email: String, password: String, firstName: String, lastName: String, profileImageUrl: String?, address: String) {
        self.id = id
        self.username = username
        self.email = email
        self.password = password
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
        
    }
    
    
}


