//
//  AddressSearchView.swift
//  FlexSub
//
//  Created by Theo Marie on 26/10/2024.
//

import SwiftUI
import MapKit




struct AddressSearchView: View {
    @State private var viewModel = AddressSearchViewModel()
    @State private var query: String = ""
    
    var body: some View {
        VStack {
            HStack {
                TextField("Rechercher une adresse", text: $query)
                    .onChange(of: query) { newValue, arguments in
                        if newValue.count > 2 { // Commence la recherche après 3 caractères
                            viewModel.search(for: newValue)
                        } else {
                            viewModel.addresses = []
                        }
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                // Bouton pour supprimer l'adresse sélectionnée
                if viewModel.isAddressSelected {
                    Button {
                        viewModel.resetAddressSelection() // Réinitialise l'état
                        query = "" // Vide le champ de texte
                    } label: {
                        Image(systemName: "multiply.circle.fill") // Icône de croix
                            .foregroundColor(.red)
                    }
                    .padding(.trailing, 10)
                }
            }
            
            if !viewModel.isAddressSelected {
                List(viewModel.addresses) { address in
                    Button(action: {
                        viewModel.selectAddress(address) // Sélectionne l'adresse
                        query = address.streetAddress // Remplit le champ de texte avec l'adresse sélectionnée
                    }) {
                        VStack(alignment: .leading) {
                            Text(address.streetAddress)
                                .font(.headline)
                            Text("\(address.city), \(address.state) \(address.zipCode)")
                                .font(.subheadline)
                            Text(address.country)
                                .font(.footnote)
                        }
                    }
                }
            } else {
                if let formattedAddress = viewModel.selectedAddress?.formattedAddress {
                    Text("Adresse sélectionnée : \(formattedAddress)")
                        .font(.headline)
                } else {
                    Text("Adresse sélectionnée : Non disponible")
                        .font(.headline)
                }
            }
        }
        .padding()
    }
    
    
}
