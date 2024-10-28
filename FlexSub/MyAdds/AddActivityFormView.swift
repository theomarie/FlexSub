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
    @State private var price: Double = 0
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
            }
            
            Section{
                HStack{
                    TextField("Prix", value: $price, format: .number)
                    Spacer()
                    Text("€")
                }
            }
            
            
            Section{
                HStack{
                    Image(systemName: "location")
                        .foregroundStyle(.tertiary)
                   // TextField("Lieu de l'établissement", text: )
                     //   .italic()
                }
            }
            
            Section{
                Button("Ajouter une nouvelle activité")
                {
                    // Attention model Activity modifs
//                    let newActivity = Activity(title: title, owner: Auth.auth().currentUser?.uid, date: date)
                    dismiss()
                }
            }
        }
    }
}


#Preview {
    AddActivityFormView()
}
