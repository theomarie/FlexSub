//
//  ActivitiesView.swift
//  FlexSub
//
//  Created by Theo Marie on 28/10/2024.
//

import SwiftUI

struct ActivitiesView: View {
    @Environment(ActivitiesViewModel.self) var activitiesViewModel
    /*
       déclarer les listes en utilisant le ActivitiesViewModel
     @Environment(ActivitiesViewModel.self) var activities
     */
    
    var body: some View {
        VStack() {
            
            // Extraire le code du picker categoy pour le mettre dans un composant et faire un appel
            /*
                Picker Category
                */
            
            SearchableActivitiesView()
            ActivitiesListView(activities: activitiesViewModel.activities)
            
        }
    }
}

#Preview {
    
    NavigationStack() {
        ActivitiesView()
            .environment(ActivitiesViewModel())
    }
 
}
