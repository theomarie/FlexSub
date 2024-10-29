//
//  UserViewModel.swift
//  FlexSub
//
//  Created by apprenant103 on 29/10/2024.
//

import SwiftUI

class UserViewModel: ObservableObject {
    @Published var user: User

    init() {
        self.user = User(id: UUID().uuidString, username: "Eikichi", email: "user@example.com", password: "motdepasse", firstName: "Abdel", lastName: "Ghani", picture: nil, address: "123 Rue Principale")
           let reviews = [
            Review(id: UUID().uuidString, rating: 4, comment: "Super utilisateur !", date: Date()),
            Review(id: UUID().uuidString, rating: 5, comment: "Je recommande !", date: Date())]
        user.reviews = reviews
    }
}
