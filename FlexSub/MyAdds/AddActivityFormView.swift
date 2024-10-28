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
                TextField("Séance Joker 2, entrée BasicFit, ... ", text: $title)
                    .italic()
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
                HStack{
                    // Si price est un String, que l'on passe après en double au moment de la création de la nouvelle instance avec Double(price)
                    TextField("0", text: $price)
                    
                    // Si price est un Double
                    //TextField("Prix", value: $price, format: .number)

                    Spacer()
                    Text("€")
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
                    //
                    dismiss()
                }
            }
          //  .listRowBackground(Color.clear)
        }
    }
}


#Preview {
    AddActivityFormView()
}
