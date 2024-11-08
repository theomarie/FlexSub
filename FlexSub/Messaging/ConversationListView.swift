//
//  ConversationListView.swift
//  FlexSub
//
//  Created by Theo Marie on 07/11/2024.
//

import SwiftUI
import ExyteChat

struct ConversationListView: View {
    @StateObject private var viewModel: ConversationListViewModel
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var authViewModel: AuthViewModel

    init() {
            _viewModel = StateObject(wrappedValue: ConversationListViewModel())
            authViewModel = AuthViewModel() // Or initialize it here
        }

    var body: some View {
        VStack {
            List(viewModel.conversations, id: \.id) { conversation in
                NavigationLink(destination: ChatActivityView(conversationId: conversation.id, currentUserId: authViewModel.currentUser?.id ?? "")) {
                    ConversationRow(conversation: conversation)
                }
            }
            .onAppear {
                if let user = authViewModel.currentUser {
                    viewModel.fetchConversations(for: user.id)
                    
                }
            }
        }
        .navigationTitle("Conversations")

        }
    
}

struct ConversationRow: View {
    let conversation: Conversation

    var body: some View {
        HStack {
            if let uiImage = UIImage(named: conversation.logo) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60) // voir comment ne pas mettre la taille de l'image en dur
                    .cornerRadius(8)
            } else {
                Image(systemName: conversation.logo) // Utilise SF Symbol
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60) // Possible reduire le code logique
                    .cornerRadius(8)
            }
            Text(conversation.title)
                .font(.headline)
            Spacer()
           
        }
    }
}

#Preview {
    ConversationListView()
}
