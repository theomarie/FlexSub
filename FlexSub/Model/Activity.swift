//
//  Activity.swift
//  FlexSub
//

//  Created by apprenant103 on 24/10/2024.
//

import SwiftUI

struct Activity: Identifiable, Codable, Hashable {
    let id:  String
    var title: String
    var status: Status = .published
    var ownerId: String
    var participantid: String?
    var price: Double = 0
    var date: Date
    var category: Category = .all // Revoir plus tard
    var address: Address
    
    var logo: String {
            // Tenter d'inférer un logo de marque basé sur le titre de l'activité
            if let brandLogo = Brand.allCases.compactMap({ $0.findBrandLogo(for: title) }).first {
                return brandLogo
            }
            
            // Si aucune marque n'est trouvée, on retourne un SF Symbol en fonction de la catégorie
            switch category {
            case .cinema:
                return "film.fill"
            case .sport:
                return "sportscourt.fill"
            case .museum:
                return "paintbrush.fill"
            case .concert:
                return "music.note"
            case .all:
                return "star.fill" // Icône par défaut pour "Tous"
            }
        }
}


//var etablissementId: Etablishement.ID? // uniquement dans un cas serveur client

