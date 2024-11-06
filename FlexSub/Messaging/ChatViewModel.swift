//
//  ChatViewModel.swift
//  FlexSub
//
//  Created by Theo Marie on 06/11/2024.
//

import FirebaseFirestore


class ChatViewModel: ObservableObject {
    @Published var conversation: Conversation?
    
    private let db = Firestore.firestore()
    
    func fetchConversation(conversationId: String) {
        db.collection("conversations").document(conversationId).getDocument { document, error in
            if let document = document, document.exists {
                do {
                    self.conversation = try document.data(as: Conversation.self)
                } catch {
                    print("Erreur lors de la conversion de la conversation : \(error)")
                }
            } else {
                print("Document de conversation non trouvé")
            }
        }
    }
}
