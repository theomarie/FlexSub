//
//  AddActivityFormView.swift
//  FlexSub
//
//  Created by Apprenant 108 on 25/10/2024.
//

import SwiftUI
import FirebaseAuth

struct AddActivityFormView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var title: String = ""
    @State private var price: String = ""
    @State private var date = Date()
    @State private var location : String = ""
    
    var body: some View {
        
        
        Form{
            Section{
                ZStack(alignment: .leading){
                    // Placeholder en italique, affiché uniquement lorsque le champ est vide
                    if title.isEmpty {
                        Text("Séance Joker 2, entrée BasicFit, ...")
                            .foregroundColor(.gray)
                            .italic()
                            .padding(.leading, 4)
                    }
                    TextField("", text: $title)
                }
            } header: {
                Text("Titre de l'activité")
                    .foregroundStyle(.blue)
            }
            
            
            Section {
                 DatePicker("Date de début", selection: $date)
            } header: {
                Text("Début de l'activité")
                    .foregroundStyle(.blue)
            }
            
            Section{
                ZStack(alignment: .leading){
                    // Placeholder en italique, affiché uniquement lorsque le champ est vide
                    if price.isEmpty {
                        Text("0")
                            .foregroundColor(.gray)
                            .italic()
                            .padding(.leading, 4)
                    }
                    HStack{
                        // Si price est un String, que l'on passe après en double au moment de la création de la nouvelle instance avec Double(price)
                        TextField("", text: $price)
                        
                        // Si price est un Double
                        //TextField("Prix", value: $price, format: .number)
                        
                        Spacer()
                        Text("€")
                    }
                }
            } header: {
                Text("Prix")
                    .foregroundStyle(.blue)
            }
            

            
            Section{
                AddressSearchView()
            } header: {
                Text("Lieu")
                    .foregroundStyle(.blue)
            }
            
            Section{
                ValidationButtonView(text: "Ajouter une activité") {
                    dismiss()
                }
            }
            .listRowInsets(EdgeInsets())
            // Supprime les marges de la cellule
            
        }
    }
}


#Preview {
    AddActivityFormView()
}
