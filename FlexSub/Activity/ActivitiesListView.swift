//
//  ActivitiesListView.swift
//  FlexSub
//
//  Created by Apprenant 82 on 24/10/2024.
//

import SwiftUI



struct ActivitiesListView: View {
    // données local sample
    let activities: [Activity] = Activity.sampleData()
    // Fin Local
    
    @State private var selectedCategory: Category = .all
    
    
    var filteredActivities: [Activity] {
        if selectedCategory == .all {
            return activities
        } else {
            return activities.filter { $0.category == selectedCategory }
        }
    }

    var body: some View {
        VStack {
            Picker("Catégorie", selection: $selectedCategory) {
                ForEach(Category.allCases) { category in
                    Text(category.rawValue).tag(category)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            List(filteredActivities) { activity in
                ActivityRow(activity: activity)
            }
            .listStyle(PlainListStyle())
        }
    }
}

#Preview {
    ActivitiesListView()
}
