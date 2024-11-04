//
//  Review.swift
//  FlexSub
//
//  Created by apprenant103 on 28/10/2024.
//

import SwiftUI

struct Review: Identifiable {
    let id: String
    var name: String
    var image: String
    var activity: String
    var rating: Double
    var comment: String
    var date: Date
    
}

let reviews = [
 Review(id: UUID().uuidString, name: "Lucie", image: "User1", activity: "Cinema", rating: 4, comment: "Super utilisateur !", date: Date()),
 Review(id: UUID().uuidString, name: "Julien", image: "User2", activity: "Cinema", rating: 5, comment: "Je recommande !", date: Date()),
 Review(id: UUID().uuidString, name: "Julie", image: "User3", activity: "Sport", rating: 4, comment: "Séance cool !", date: Date()),
 Review(id: UUID().uuidString, name: "Jul", image: "User4", activity: "Cinema", rating: 5, comment: "Personne sympathique !", date: Date()),
 Review(id: UUID().uuidString, name: "Laure", image: "User5", activity: "Musée", rating: 4, comment: "Utilisateur passionée", date: Date()),
 Review(id: UUID().uuidString, name: "Shrek", image: "shrek", activity: "Sport", rating: 4, comment: "Séance cool !", date: Date()),
 
]

