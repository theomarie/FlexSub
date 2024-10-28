//
//  Activity.swift
//  FlexSub
//
<<<<<<< HEAD
//  Created by apprenant103 on 24/10/2024.
//

import SwiftUI

struct Activity: Identifiable {
    let id = UUID()
    var title: String
    var status: Status = .published
    var owner: User.ID
    var participant: User.ID?
    var price: Double = 0
    var date: Date
    var category: Category = .all // Revoir plus tard 
    var etablissementId: Etablishement.ID?
}
=======
//  Created by Apprenant 82 on 24/10/2024.
//

import Foundation
import SwiftUI

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
    let category: Category
    let etablissement: Etablissement // Remplacer `etablissementId` par `etablissement`
    let location: String // Lieu de l'activité
    let distance: Double // Distance par rapport à l'utilisateur (en km)
}

>>>>>>> Nicolas
