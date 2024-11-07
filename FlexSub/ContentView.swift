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
                ActivitiesView(activitiesViewModel: activitiesViewModel)
            }
            
            Tab("Mes annonces", systemImage: "light.panel") {
                    MyAdsView(activitiesViewModel: activitiesViewModel)
            }
            
            Tab("Messagerie", systemImage: "message.fill") {
                ChatActivityView(conversationId: "21EC3386-52B4-42D6-8C86-86D9491FC072",
                currentUserId: "wYndYiYuFhMLhFFKdoEQgqy5w7z2")
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
