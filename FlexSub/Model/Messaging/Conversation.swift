//
//  Message.swift
//  FlexSub
//
//  Created by Theo Marie on 05/11/2024.
//

import SwiftUI
import FirebaseFirestore
import ExyteChat

struct Conversation: Codable, Identifiable {
    let id: String
    let title: String
    let userMessaging: [ChatParticipant]
    
    var category: Category = .all 
    
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
 




