//
//  ChatViewModel.swift
//  FlexSub
//
//  Created by Theo Marie on 06/11/2024.
//

import FirebaseFirestore
import ExyteChat

class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var conversation: Conversation?
    private var db = Firestore.firestore()
    private var messagesListener: ListenerRegistration?
    private var conversationListener: ListenerRegistration?
    
    init(conversationId: String) {
        setupConversationListener(conversationId: conversationId)
        setupMessagesListener(conversationId: conversationId)
    }
    
    private func setupConversationListener(conversationId: String) {
        conversationListener = db.collection("conversations")
            .document(conversationId)
            .addSnapshotListener { [weak self] documentSnapshot, error in
                guard let document = documentSnapshot else {
                    print("Error fetching conversation: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                
                guard let data = document.data() else { return }
                
                let userMessaging = (data["userMessaging"] as? [[String: Any]] ?? []).map { userData in
                    ChatParticipant(
                        id: userData["id"] as? String ?? "",
                        name: userData["name"] as? String ?? "",
                        avatarURL: userData["avatarURL"] as? String ?? "",
                        isCurrentUser: userData["isCurrentUser"] as? Bool ?? false
                    )
                }
                
                self?.conversation = Conversation(
                    id: document.documentID,
                    title: data["title"] as? String ?? "",
                    userMessaging: userMessaging
                )
            }
    }
    
    private func setupMessagesListener(conversationId: String) {
        let messagesRef = db.collection("conversations")
            .document(conversationId)
            .collection("messages")
        
        messagesListener = messagesRef
            .order(by: "timestamp", descending: false)
            .addSnapshotListener { [weak self] querySnapshot, error in
                guard let documents = querySnapshot?.documents,
                      let conversation = self?.conversation else {
                    print("Error fetching messages: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                
                self?.messages = documents.compactMap { document in
                    let data = document.data()
                    /*
                    let attachments = (data["attachments"] as? [[String: Any]] ?? []).map { attachmentData in
                        FirestoreAttachment(
                            id: attachmentData["id"] as? String ?? UUID().uuidString,
                            url: attachmentData["url"] as? String ?? "",
                            type: attachmentData["type"] as? String ?? "image",
                            thumbnailUrl: attachmentData["thumbnailUrl"] as? String
                        )
                    }
                     */
                    
                    let message = FirestoreMessage(
                        id: document.documentID,
                        senderId: data["senderId"] as? String ?? "",
                        content: data["content"] as? String ?? "",
                        timestamp: (data["timestamp"] as? Timestamp)?.dateValue() ?? Date(),
                        //attachments: attachments,
                        replyMessageId: data["replyMessageId"] as? String,
                        status: data["status"] as? String ?? "sent"
                    )
                    
                    return message.toExyteChatMessage(users: conversation.userMessaging)
                }
            }
    }
    
    func sendMessage(text: String, currentUserId: String) {
            guard let conversationId = conversation?.id else { return }
            
            let messageData: [String: Any] = [
                "senderId": currentUserId,
                "content": text,
                "timestamp": Timestamp(date: Date()),
                "status": "sent",
                "attachments": []
            ]
            
            db.collection("conversations")
                .document(conversationId)
                .collection("messages")
                .addDocument(data: messageData) { error in
                    if let error = error {
                        print("Error sending message: \(error.localizedDescription)")
                    }
                }
        }
        
        deinit {
            messagesListener?.remove()
            conversationListener?.remove()
        }
}
