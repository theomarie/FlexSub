//
//  Activity.swift
//  FlexSub
//
//  Created by Apprenant 82 on 24/10/2024.
//

import Foundation

// Enum pour les catégories d'activités
enum ActivityCategory: String, CaseIterable {
    case cinema = "Cinéma"
    case sport = "Sport"
    case museum = "Musée"
    case concert = "Concert"
}

// Enum pour le statut de l'activité
enum ActivityStatus {
    case published
    case cancelled
    case completed
}

struct Activity: Identifiable {
    let id = UUID()
    let title: String
    var status: ActivityStatus = .published
    let owner: User // Propriétaire de l'activité
    var participant: User? // Participant optionnel
    let price: Double
    let date: Date
    let category: ActivityCategory
    let etablissementId: Int
    let location: String // Lieu de l'activité
    let distance: Double // Distance par rapport à l'utilisateur (en km)
}
