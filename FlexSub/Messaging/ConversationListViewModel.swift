//
//  ConversationListViewModel.swift
//  FlexSub
//
//  Created by Theo Marie on 07/11/2024.
//

import Combine
import FirebaseFirestore
import ExyteChat

class ConversationListViewModel: ObservableObject {
    @Published var conversations: [Conversation] = []
    private var db = Firestore.firestore()
    private var conversationsListener: ListenerRegistration?
    private var userId: String?

    func fetchConversations(for userId: String) {
        self.userId = userId

        conversationsListener = db.collection("conversations")
            .addSnapshotListener { [weak self] querySnapshot, error in
                if let error = error {
                    print("Error fetching conversations: \(error.localizedDescription)")
                    return
                }

                if let querySnapshot = querySnapshot {
                    var userConversations: [Conversation] = []
                    for document in querySnapshot.documents {
                        let data = document.data()
                        let userMessaging = (data["userMessaging"] as? [[String: Any]] ?? []).filter { userData in
                            (userData["id"] as? String) == userId
                        }

                        if !userMessaging.isEmpty {
                            userConversations.append(Conversation(
                                id: document.documentID,
                                title: data["title"] as? String ?? "",
                                userMessaging: userMessaging.map { userData in
                                    ChatParticipant(
                                        id: userData["id"] as? String ?? "",
                                        name: userData["name"] as? String ?? "",
                                        avatarURL: userData["avatarURL"] as? String ?? "",
                                        isCurrentUser: userData["isCurrentUser"] as? Bool ?? false
                                    )
                                }
                            ))
                        }
                    }
                    print("Conversations found: \(userConversations.count)")
                    self?.conversations = userConversations
                } else {
                    print("No conversations found for userId: \(userId)")
                    self?.conversations = []
                }
            }
    }

    deinit {
        conversationsListener?.remove()
    }
}
