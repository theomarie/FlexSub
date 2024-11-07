//
//  ChatActivityView.swift
//  FlexSub
//
//  Created by Theo Marie on 06/11/2024.
//

import SwiftUI
import ExyteChat

struct ChatActivityView: View {
    @StateObject private var viewModel: ChatViewModel
    let currentUserId: String
    
    init(conversationId: String, currentUserId: String) {
        self.currentUserId = currentUserId
        _viewModel = StateObject(wrappedValue: ChatViewModel(conversationId: conversationId))
    }
    
    var body: some View {
        VStack {
            if let conversation = viewModel.conversation {
                Text(conversation.title)
                    .font(.headline)
                    .padding()
                
                ChatView(
                    messages: viewModel.messages,
                    didSendMessage: { draft in
                           viewModel.sendMessage(text: draft.text, currentUserId: currentUserId)
                       }                )
                .setAvailableInput(.textOnly)
            } else {
                ProgressView()
            }
        }
        .navigationBarTitle("Conversation", displayMode: .inline)
    }
}

#Preview {
    ChatActivityView(
        conversationId: "21EC3386-52B4-42D6-8C86-86D9491FC072",
        currentUserId: "wYndYiYuFhMLhFFKdoEQgqy5w7z2"
    )
}
