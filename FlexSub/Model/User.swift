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
    var address: String?
  //  var phone: String? voir peut etre un protocol pour la gestion des numéros
    
    
    
    static func sampleData() -> [User] {
           return [
               User(username: "john_doe", email: "john.doe@example.com", password: "password123", firstName: "John", lastName: "Doe", picture: UIImage(systemName: "person.fill"), address: "123 Main St, Paris, France"),
               User(username: "jane_smith", email: "jane.smith@example.com", password: "password123", firstName: "Jane", lastName: "Smith", picture: UIImage(systemName: "person.fill"), address: "456 Elm St, Lyon, France"),
               User(username: "mike_jones", email: "mike.jones@example.com", password: "password123", firstName: "Mike", lastName: "Jones", picture: UIImage(systemName: "person.fill"), address: "789 Oak St, Bordeaux, France"),
               User(username: "emma_williams", email: "emma.williams@example.com", password: "password123", firstName: "Emma", lastName: "Williams", picture: UIImage(systemName: "person.fill"), address: "321 Maple St, Lille, France"),
               User(username: "lucas_brown", email: "lucas.brown@example.com", password: "password123", firstName: "Lucas", lastName: "Brown", picture: UIImage(systemName: "person.fill"), address: "654 Pine St, Nice, France")
           ]
       }
    
    init(id: UUID = UUID(), username: String, email: String, password: String, firstName: String? = nil, lastName: String? = nil, picture: UIImage? = nil, address: String? = nil) {
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


