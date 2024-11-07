//
//  ActivitiesView.swift
//  FlexSub
//
//  Created by Theo Marie on 28/10/2024.
//

import SwiftUI
import FirebaseAuth

struct ActivitiesView: View {
    @Bindable var activitiesViewModel: ActivitiesViewModel
    var user = Auth.auth().currentUser
    
    
    var body: some View {
        
        Group {
            switch activitiesViewModel.activitiesState {
            case .idle:
                Color.clear
            case .loading:
                ProgressView()
            case .success:
                VStack() {
                    SearchableActivitiesView(activitiesViewModel: activitiesViewModel)
                    ActivitiesListView(activitiesViewModel: activitiesViewModel)
                    
                }
                .navigationTitle("Activités")

            case .error(let error):
                // ErrorView(error: error)
                Text("Error: \(error.localizedDescription)")
            }
        }
        .task {
            guard let userId = user?.uid else { return }
            await activitiesViewModel.fetchActivities(userId: userId)
        }
    }
    
}

#Preview {
    NavigationStack() {
        ActivitiesView(activitiesViewModel: ActivitiesViewModel())
    }
    
}
