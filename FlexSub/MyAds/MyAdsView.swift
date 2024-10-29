//
//  MyAddsView.swift
//  FlexSub
//
//  Created by Apprenant 108 on 25/10/2024.
//

import SwiftUI

struct MyAdsView: View {
    
    /*
     Variable pour le test d'affichage conditionnel.
     A remplacer plus tard par le nombre d'éléments du tableau myActivities
     */
    var count : Int = 0
    
    @State var showAddingField: Bool = false
    
    var body: some View {
        VStack{
            if count == 0{
                Text("Vous trouverez ici le détail des activités que vous avez partagées.\n\nPartagez une nouvelle activité en appuyant sur le ")
                    .font(.title3)
                
                + Text(Image(systemName: "plus"))
                    .foregroundStyle(.blue)
                    .font(.title3)
                
                + Text(" en haut à droite.")
                    .font(.title3)
                
                Spacer()
                
            } else {
                // Affichage des activités
            }
        }
        .padding(32)
        .navigationTitle("Mes activités")
        .toolbar {
            NavigationLink(destination: AddActivityFormView()) {
                Label("Partager une activité", systemImage: "plus")
            }
        }
    }
}

#Preview {
    NavigationStack {
        MyAdsView()
    }
    
}
