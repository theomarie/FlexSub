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
                        selectedActivity = activity
                    }
            }
            .listStyle(PlainListStyle())
        }
        .navigationDestination(item: $selectedActivity) { activity in
                       ActivityReservationView(activity: activity)
                   }    }
        
}

#Preview {
    ActivitiesListView(activitiesViewModel: ActivitiesViewModel())
}
