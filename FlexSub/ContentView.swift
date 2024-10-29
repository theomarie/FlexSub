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

    @StateObject var userData = UserData() 

    var body: some View {
        TabView {
            Tab("Activités", systemImage: "star") {
                NavigationStack() {
                    ActivitiesView()
                }
            }
            
            Tab("Mes annonces", systemImage: "light.panel") {
                NavigationStack() {
                    MyAdsView()
                }
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
       
        .environment(ActivitiesViewModel())
    }
}
   

#Preview {
  
    ContentView()
     
}
