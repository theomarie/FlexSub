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
    @Environment(AuthViewModel.self) var authViewModel
    @Environment(ActivitiesViewModel.self) var activitiesViewModel
    @State private var selectedCategory: Category = .all // Catégorie sélectionnée
    @State private var title: String = ""
    @State private var price: String = ""
    @State private var date = Date()
    @State private var location : String = ""
    
    var body: some View {
        Form{
            Section{
                TextField("Séance Joker 2, entrée BasicFit, ...", text: $title)
                    .italic(Bool(title.isEmpty))
            } header: {
                Text("Titre de l'activité")
                    .foregroundStyle(.blue)
            }
            Section {
                Picker("Catégorie", selection: $selectedCategory) {
                    ForEach(Category.allCases) { category in
                        Text(category.name).tag(category)
                    }
                }
                .pickerStyle(MenuPickerStyle()) // Affiche le picker comme un menu déroulant
            }
            
            Section {
                DatePicker("Date de début", selection: $date)
            } header: {
                Text("Début de l'activité")
                    .foregroundStyle(.blue)
            }
            
            Section{
                HStack{
                    TextField("0", text: $price)
                        .italic(Bool(price.isEmpty))
                    Spacer()
                    Text("€")
                }
            }
            Section{
                AddressSearchView()
            } header: {
                Text("Lieu")
                    .foregroundStyle(.blue)
            }
            
            Section{
                ValidationButtonView(text: "Ajouter une activité") {
                    addActivity()
                }
                .listRowInsets(EdgeInsets())

            }
        }
    }
    func addActivity() {
        guard let priceValue = Double(price) else {
            print("Erreur : le prix doit être un nombre valide.")
            return
        }
        
        guard let currentUser = Auth.auth().currentUser else {
            print("Utilisateur non authentifié.")
            return
        }
        
        
        
        let newActivity = Activity(
            id: UUID().uuidString,
            title: title,
            ownerId: currentUser.uid,
            participant: nil,
            price: priceValue,
            date: date,
            category: selectedCategory, // Utilise la catégorie sélectionnée
            address: Address(
                streetAddress: location,
                city: "Paris",
                formattedAddress: location,
                state: "Ile-de-France",
                zipCode: "75001",
                country: "France",
                lng: 2.3522,
                lat: 48.8566
            )
        )
        
        activitiesViewModel.addActivity(activity: newActivity)
        dismiss()
    }
}



#Preview {
    AddActivityFormView()
        .environment(ActivitiesViewModel())
        .environment(AuthViewModel())
}
