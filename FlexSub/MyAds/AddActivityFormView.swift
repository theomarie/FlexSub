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
                ZStack(alignment: .leading){
                    // Placeholder en italique, affiché uniquement lorsque le champ est vide
                    HStack{
                        // Si price est un String, que l'on passe après en double au moment de la création de la nouvelle instance avec Double(price)
                        TextField("0", text: $price)
                            .foregroundColor(price.count == 1 ?  .gray : .black)
                            .italic(Bool(price.count == 1))
                        
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
                        //
                        addActivity()
                    }
                }
                
                //  .listRowBackground(Color.clear)
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
