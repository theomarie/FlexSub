//
//  ActivitiesView.swift
//  FlexSub
//
//  Created by Theo Marie on 28/10/2024.
//

import SwiftUI

struct ActivitiesView: View {
    
    /*
       déclarer les listes en utilisant le ActivitiesViewModel
     */
    
    var body: some View {
        VStack() {
            
            // Extraire le code du picker categoy pour le mettre dans un composant et faire un appel
            /*
                Picker Category
                */
            
            SearchableActivitiesView()
            ActivitiesListView()
            
        }
    }
}

#Preview {
    NavigationStack() {
        ActivitiesView()
    }
 
}
