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
    //@Environment(AuthViewModel.self) var authViewModel
    var isMyActivities = false
    
    var body: some View {
        VStack {
            Picker("Catégorie", selection: $activitiesViewModel.selectedCategory) {
                ForEach(Category.allCases) { category in
                    Text(category.rawValue).tag(category)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            
            List{
                
                if isMyActivities{Text(activitiesViewModel.activities.count > 1 ? "Vous avez partagé \(activitiesViewModel.activities.count) activités" : "Vous avez partagé \(activitiesViewModel.activities.count) activité ")}
                
                ForEach(activitiesViewModel.filteredActivities) { activity in
                    ActivityRow(activity: activity)
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button {
                                activitiesViewModel.deleteActivityToFirestore(activity: activity)
                            } label: {
                                Image(systemName: "trash")
                            }

                        }
                        .onTapGesture {
                            // Ne permet la sélection de l'activité que si l'utilisateur est connecté
                            selectedActivity = activity
                        }
                }
    
            }
            .listStyle(PlainListStyle())
        }
        .navigationDestination(item: $selectedActivity) { activity in
            ActivityReservationView(reservationViewModel: ActivityReservationViewModel(activity: activity, activitieState: .idle), activity: activity, userId: activity.ownerId)
            
        }
    }
}

#Preview {
    ActivitiesListView(activitiesViewModel: ActivitiesViewModel())
}
