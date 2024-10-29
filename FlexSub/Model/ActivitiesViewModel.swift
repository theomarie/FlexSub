//
//  Catalog.swift
//  FlexSub
//
//  Created by Apprenant 108 on 25/10/2024.
//

import Foundation

@Observable class ActivitiesViewModel {
    var activities : [Activity] = Activity.sampleData()
    var searchText: String = ""
    var selectedCategory: Category = .all

    
    var filteredActivities: [Activity] {
           activities.filter { activity in
               (selectedCategory == .all || activity.category == selectedCategory) &&
               (searchText.isEmpty || activity.title.lowercased().contains(searchText.lowercased()))
           }
       }

       func addActivity(activity: Activity) {
           activities.append(activity)
       }

       func myActivities(userId: String) -> [Activity] {
           activities.filter { $0.ownerId == userId }
       }
}

