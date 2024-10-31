//
//  MyAddsView.swift
//  FlexSub
//
//  Created by Apprenant 108 on 25/10/2024.
//

import SwiftUI
import FirebaseAuth

struct MyAdsView: View {
    @Bindable var activitiesViewModel: ActivitiesViewModel
    var user = Auth.auth().currentUser

    
    var body: some View {
        VStack{
            if activitiesViewModel.activities.isEmpty{
                Text("Vous trouverez ici le détail des activités que vous avez partagées.\n\nPartagez une nouvelle activité en appuyant sur le ")
                    .font(.title3)
                
                + Text(Image(systemName: "plus"))
                    .foregroundStyle(.blue)
                    .font(.title3)
                
                + Text(" en haut à droite.")
                    .font(.title3)
                
                Spacer()
                
            } else {
                ActivitiesListView(activitiesViewModel: activitiesViewModel)
            }
        }
        .navigationTitle("Mes activités")
        .toolbar {
            NavigationLink(destination: AddActivityFormView()) {
                Label("Partager une activité", systemImage: "plus")
            }
        }
        .onAppear() {
            guard let userId = user?.uid else { return }
            self.activitiesViewModel.fetchMyActivities(for: userId)
        }
    }
}

#Preview {
    NavigationStack {
        MyAdsView(activitiesViewModel: ActivitiesViewModel())
            .navigationTitle("Mes activités")
    }
    
}
