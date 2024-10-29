//
//  ActivitiesView.swift
//  FlexSub
//
//  Created by Theo Marie on 28/10/2024.
//

import SwiftUI

struct ActivitiesView: View {
    @Environment(ActivitiesViewModel.self) var activitiesViewModel
    var body: some View {
        VStack() {
            SearchableActivitiesView(activitiesViewModel: activitiesViewModel)
            ActivitiesListView(activitiesViewModel: activitiesViewModel)
            
        }
    }
}

#Preview {
    NavigationStack() {
        ActivitiesView()
            .environment(ActivitiesViewModel())
    }
 
}
