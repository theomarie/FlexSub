//
//  Catalog.swift
//  FlexSub
//
//  Created by Apprenant 108 on 25/10/2024.
//

import Foundation

@Observable class ActivitiesViewModel {
    var activities : [Activity] = Activity.sampleData()
    

    
    func myActivities(userID: UUID) -> [Activity]? {
        return nil
    }
    
    func addActivity(activity: Activity) {
        activities.append(activity)
    }
    
    func trieSearchBar() -> [Activity] {
        return []
    }
}

