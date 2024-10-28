//
//  ContentView.swift
//  FlexSub
//
//  Created by Theo Marie on 23/10/2024.
//

import SwiftUI




struct ContentView: View {
    @Environment(AuthViewModel.self) var authViewModel
    var body: some View {
        TabView {
            Tab("Activités", systemImage: "star") {
                // Vue Activités
            }
            
            Tab("Mes annonces", systemImage: "light.panel") {
                // Vue Mes annonces
            }
            
            Tab("Messagerie", systemImage: "message.fill") {
                // Vue Messagerie
            }

            Tab("Profil", systemImage: "person.crop.square") {
                Button("Logout") {
                    authViewModel.logout()
                }
            }
        }
    }
}

#Preview {
    
    ContentView()
}
