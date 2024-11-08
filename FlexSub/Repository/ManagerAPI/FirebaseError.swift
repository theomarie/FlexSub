//
//  FirebaseError.swift
//  FlexSub
//
//  Created by Theo Marie on 29/10/2024.
//

import Foundation

enum FirebaseError: LocalizedError {
    case decodingError
    case noDocuments
    case custom(String)
    
    var errorDescription: String? {
        switch self {
        case .decodingError:
            return "Erreur lors du décodage des données"
        case .noDocuments:
            return "Aucun document trouvé"
        case .custom(let message):
            return message
        }
    }
}
