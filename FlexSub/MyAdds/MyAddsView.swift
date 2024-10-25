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
    
    var body: some View {
        NavigationStack{
            
            VStack{
                if count == 0{
                    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                } else {
                    Form{
                        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                    }
                }
            }
            .navigationTitle("Mes activités")
            
        }
    }
}

#Preview {
    MyAddsView()
}
