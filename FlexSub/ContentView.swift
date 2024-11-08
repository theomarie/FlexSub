//
//  ContentView.swift
//  FlexSub
//
//  Created by Theo Marie on 23/10/2024.
//

import SwiftUI
import FirebaseAuth



struct ContentView: View {
    // environnement de mon activites
    @Environment(AuthViewModel.self) var authViewModel
    @Environment(ActivitiesViewModel.self) var activitiesViewModel
    
    // code Abdelghani
    @StateObject var userData = UserData()
    // Fin du code
    
    var body: some View {
        
        TabView {
            Tab("Activités", systemImage: "star") {
                NavigationStack {
                    ActivitiesView(activitiesViewModel: activitiesViewModel)
                }
            }
            
            Tab("Mes annonces", systemImage: "light.panel") {
                NavigationStack {
                    MyAdsView(activitiesViewModel: activitiesViewModel)
                }
            }
            
            Tab("Messagerie", systemImage: "message.fill") {
                NavigationStack {
                    ConversationListView()
                }
            }
            
            Tab("Profil", systemImage: "person.crop.square") {
                NavigationStack {
                    Button("Logout") {
                        authViewModel.logout()
                    }
                }
                
            }
        }
        .onAppear {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            
        }
    }
    
}



#Preview {
    
    ContentView()
    
}
