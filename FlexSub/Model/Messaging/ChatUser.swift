//
//  Conversation.swift
//  FlexSub
//
//  Created by Theo Marie on 05/11/2024.
//

import Foundation
import FirebaseFirestore
import ExyteChat

typealias ChatUser = ExyteChat.User

struct ChatParticipant: Codable {
    let id: String
    let name: String
    let avatarURL: String?
    let isCurrentUser: Bool
    
    // Conversion vers le User d'ExyteChat
    func toChatUser() -> ChatUser {
        ChatUser(
            id: id,
            name: name,
            avatarURL: avatarURL.flatMap { URL(string: $0) }, // Conversion de String? en URL?
            isCurrentUser: isCurrentUser
        )
    }
}

// Extension utilitaire pour gérer les URLs
extension ChatParticipant {
    // Helper pour obtenir l'URL de l'avatar de manière sûre
    var avatarAsURL: URL? {
        guard let urlString = avatarURL else { return nil }
        return URL(string: urlString)
    }
}
