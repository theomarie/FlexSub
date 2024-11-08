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
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(ActivitiesViewModel.self) var activitiesViewModel
    
    
    
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
                    UserView()
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
    



   

//#Preview {
//  
//    ContentView()
//     
//}
