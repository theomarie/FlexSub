//
//  MyAddsView.swift
//  FlexSub
//
//  Created by Apprenant 108 on 25/10/2024.
//

import SwiftUI

struct MyAddsView: View {
    
/*
Variable pour le test d'affichage conditionnel.
A remplacer plus tard par le nombre d'éléments du tableau myActivities
 */
    var count : Int = 0
    
    @State var showAddingField: Bool = false
    
    var body: some View {
            VStack{
                if count == 0{
                    Text("Partagez une activité")
                } else {
                    Form{
                        Text("Annonce 1")
                        Text("Annonce 2")
                    }
                }
            }
            .navigationTitle("Mes activités")
            .toolbar {
                Button {
                    showAddingField = true
                } label: {
                    Image(systemName: "plus")
                }
                .sheet(isPresented: $showAddingField) {
                    AddActivityFormView()
                }
            }
        }
    }

#Preview {
    MyAddsView()
}
