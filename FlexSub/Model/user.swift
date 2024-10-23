//
//  user.swift
//  FlexSub
//
//  Created by Theo Marie on 23/10/2024.
//


import SwiftUI

class User: Identifiable, Codable {
    var id = UUID()
    var username: String
    var email: String
  //  var phone: String? voir peut etre un protocol pour la gestion des numéros
    
    init(id: UUID = UUID(), username: String, email: String) {
        self.id = id
        self.username = username
        self.email = email
       // self.phone = phone
    }
    
    
    enum CodingKeys: String, CodingKey {
        case username
        case email
        
    }
    
}
