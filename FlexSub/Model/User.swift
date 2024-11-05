//
//  user.swift
//  FlexSub
//
//  Created by Theo Marie on 23/10/2024.
//


import SwiftUI
import FirebaseFirestore


class User: Identifiable, Equatable {
    var id: String
    public let isCurrentUser: Bool = false
    var username: String
    var email: String
    var firstName: String
    var lastName: String
    var profileImageUrl: String? = "gs://flexsub-edf76.appspot.com/profile_images/fdsfsfe874894894894.jpg"
    var address: String
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
    
    static func == (lhs: User, rhs: User) -> Bool {
           return lhs.id == rhs.id &&
                  lhs.username == rhs.username &&
                  lhs.email == rhs.email
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


