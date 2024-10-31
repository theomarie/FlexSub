//
//  ActivitiesListView.swift
//  FlexSub
//
//  Created by Apprenant 82 on 24/10/2024.
//

import SwiftUI



struct ActivitiesListView: View {
    @Bindable var activitiesViewModel: ActivitiesViewModel
    @State private var selectedActivity: Activity? // Pour suivre l'activité sélectionnée
    @Environment(AuthViewModel.self) var authViewModel
    
    var body: some View {
        VStack {
            Picker("Catégorie", selection: $activitiesViewModel.selectedCategory) {
                ForEach(Category.allCases) { category in
                    Text(category.rawValue).tag(category)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            List(activitiesViewModel.filteredActivities) { activity in
                ActivityRow(activity: activity)
                    .onTapGesture {
                        // Ne permet la sélection de l'activité que si l'utilisateur est connecté
                        if authViewModel.currentUser != nil {
                            selectedActivity = activity
                        }
                    }
            }
            .listStyle(PlainListStyle())
            
            // Si l'utilisateur n'est pas connecté, on affiche un message ou une vue alternative
            if authViewModel.currentUser == nil {
                Text("Veuillez vous connecter pour accéder aux détails des activités.")
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .navigationDestination(item: $selectedActivity) { activity in
            // Passe l'utilisateur uniquement si `currentUser` existe
            if let user = authViewModel.currentUser {
                ActivityReservationView(activity: activity, user: user)
            }
        }
    }
}

#Preview {
    ActivitiesListView(activitiesViewModel: ActivitiesViewModel())
}
