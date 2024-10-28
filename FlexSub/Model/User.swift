//
//  user.swift
//  FlexSub
//
//  Created by Theo Marie on 23/10/2024.
//


import SwiftUI

class User: Identifiable {
    var id = UUID()
    var username: String
    var email: String
    var password: String
    var firstName: String
    var lastName: String
    var picture: UIImage?
    var address: String
    var reviews: [Review] = []  // Liste des avis pour cet utilisateur
  //  var phone: String? voir peut etre un protocol pour la gestion des numéros
    
    init(id: UUID = UUID(), username: String, email: String, password: String, firstName: String, lastName: String, picture: UIImage? = nil, address: String) {
        self.id = id
        self.username = username
        self.email = email
        self.password = password
        self.firstName = firstName
        self.lastName = lastName
        self.picture = picture
        self.address = address
       // self.phone = phone
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


