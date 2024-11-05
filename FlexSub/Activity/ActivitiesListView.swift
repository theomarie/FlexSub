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
                            selectedActivity = activity
                    }
            }
            .listStyle(PlainListStyle())
            
        }
        .navigationDestination(item: $selectedActivity) { activity in
            ActivityReservationView(reservationViewModel: ActivityReservationViewModel(activity: activity, activitieState: .idle), userId: activity.ownerId)
        
        }
    }
}

#Preview {
    ActivitiesListView(activitiesViewModel: ActivitiesViewModel())
}
