//
//  ActivitiesListView.swift
//  FlexSub
//
//  Created by Apprenant 82 on 24/10/2024.
//

import SwiftUI



struct ActivitiesListView: View {
    @Bindable var activitiesViewModel: ActivitiesViewModel

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
            }
            .listStyle(PlainListStyle())
        }
    }
}

#Preview {
    ActivitiesListView(activitiesViewModel: ActivitiesViewModel())
}
