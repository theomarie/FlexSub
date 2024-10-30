//
//  ContentView.swift
//  FlexSub
//
//  Created by Theo Marie on 23/10/2024.
//

import SwiftUI




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
                NavigationStack() {
                    ActivitiesView(activitiesViewModel: activitiesViewModel)
                }
            }
            
            Tab("Mes annonces", systemImage: "light.panel") {
                NavigationStack() {
                    MyAdsView(activitiesViewModel: activitiesViewModel)
                }
            }
            
            Tab("Messagerie", systemImage: "message.fill") {
                // Vue Messagerie
            }
            
            Tab("Profil", systemImage: "person.crop.square") {
                NavigationStack {
                    UserView()
                }
                
            }
        }
       
       
    }
}
   

#Preview {
  
    ContentView()
     
}
