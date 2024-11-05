//
//  Conversation.swift
//  FlexSub
//
//  Created by Theo Marie on 05/11/2024.
//

import Foundation
import FirebaseFirestore

public struct Conversation: Identifiable, Hashable, Encodable {
    public let id: String
    public let userMessaging: [UserMessaging]
    public let title: String
    public let latestMessage: Message?

    
    
    
    
    
    
    
    static func createChatBetweenUsers(user1: UserMessaging, user2: UserMessaging, activityTitle: String, activityId: String) {
        let conversation = Conversation(id: activityId, userMessaging: [user1, user2], title: activityTitle, latestMessage: nil)

        // Ajoute la conversation à Firestore
        let db = Firestore.firestore()
        db.collection("conversations").document(conversation.id).setData(try! Firestore.Encoder().encode(conversation)) { error in
            if let error = error {
                print("Erreur lors de la création de la conversation : \(error)")
            } else {
                print("Conversation créée avec succès : \(conversation.id)")
            }
        }
    }
}
