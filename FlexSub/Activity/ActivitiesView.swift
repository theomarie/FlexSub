//
//  ActivitiesView.swift
//  FlexSub
//
//  Created by Theo Marie on 28/10/2024.
//

import SwiftUI

struct ActivitiesView: View {
    @Bindable var activitiesViewModel: ActivitiesViewModel
    
    var body: some View {
        VStack() {
            SearchableActivitiesView(activitiesViewModel: activitiesViewModel)
            ActivitiesListView(activitiesViewModel: activitiesViewModel)
            
        }
    }
}

#Preview {
    NavigationStack() {
        ActivitiesView(activitiesViewModel: ActivitiesViewModel())
    }
 
}
