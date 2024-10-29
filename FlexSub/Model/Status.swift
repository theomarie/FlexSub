//
//  Status.swift
//  FlexSub
//
//  Created by apprenant103 on 24/10/2024.
//





enum Status: String, Statutes, Codable {
    case published = "Publier"
    case inProgress = "En cours"
    case awaiting = "En attente"
    case fineshed = "Terminé"

    var name: String {
        return self.rawValue
    }

    static var allStatutes: [Status] {
        return [.published, .inProgress, .awaiting, .fineshed]
    }
    
}
