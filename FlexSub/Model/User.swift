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
    var firstName: String?
    var lastName: String?
    var picture: UIImage?
    var address: String
    var image: Image? // Image de type SwiftUI

    init(
        id: UUID = UUID(),
        username: String,
        email: String,
        password: String,
        firstName: String? = nil,
        lastName: String? = nil,
        picture: UIImage? = nil,
        address: String,
        image: Image? = nil // Ajout de l'image ici
    ) {
        self.id = id
        self.username = username
        self.email = email
        self.password = password
        self.firstName = firstName
        self.lastName = lastName
        self.picture = picture
        self.address = address
        self.image = image
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


