//
//  FirestoreMessage.swift
//  FlexSub
//
//  Created by Theo Marie on 05/11/2024.
//

import Firebase
import FirebaseFirestore
import Foundation
import ExyteChat


struct FirestoreMessage: Codable, Identifiable {
    let id: String
    let senderId: String
    let content: String
    let timestamp: Date
    //let attachments: [FirestoreAttachment]
    let replyMessageId: String?
    let status: String
    
    func toExyteChatMessage(users: [ChatParticipant]) -> Message {
        let sender = users.first { $0.id == senderId } ?? ChatParticipant(
            id: senderId,
            name: "Unknown",
            avatarURL: nil,
            isCurrentUser: false
        )
        
        return Message(
            id: id,
            user: sender.toChatUser(), // Utilisation de la conversion
            status: convertStatus(status),
            createdAt: timestamp,
            text: content
           // attachments: attachments.map { $0.toAttachment() }
        )
    }
    
    private func convertStatus(_ status: String) -> Message.Status {
        switch status {
        case "sending": return .sending
        case "sent": return .sent
        case "read": return .read
        default: return .sent
        }
    }
}
