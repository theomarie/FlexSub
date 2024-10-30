//
//  UserData.swift
//  FlexSub
//
//  Created by apprenant103 on 25/10/2024.
//

import SwiftUI

class UserData: ObservableObject {
    @Published var user: User = User(id: UUID().uuidString, username: "", email: "", password: "", firstName: "", lastName: "", profileImageUrl: "", address: "")
    @Published var inputImage: UIImage?
    
    init() {
        self.user = User(id: UUID().uuidString, username: "Eikichi", email: "user@example.com", password: "motdepasse", firstName: "Abdel", lastName: "Ghani", profileImageUrl: "", address: "123 Rue Principale")
        
            // Création des instances de Review (à adapter avec des ID valides)
        /*
            let review1 = Review(id: UUID(), authorId: UUID(), userId: user.id, rating: 4, comment: "Super utilisateur !", date: Date())
            let review2 = Review(id: UUID(), authorId: UUID(), userId: user.id, rating: 5, comment: "Je recommande !", date: Date())
            self.user.reviews = [review1, review2]
         */
        }
}
