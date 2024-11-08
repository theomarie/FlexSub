//
//  AddressSearchViewModel.swift
//  FlexSub
//
//  Created by Theo Marie on 26/10/2024.
//

import Foundation
import MapKit
import Combine



@Observable class AddressSearchViewModel {
    var addresses: [Address] = []
    var selectedAddress: Address?
    var isAddressSelected: Bool = false // État de sélection de l'adresse
    var cancellables = Set<AnyCancellable>()
    
    func search(for query: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)) // Changez les coordonnées par défaut selon votre besoin
        
        let search = MKLocalSearch(request: request)
        
        search.start { [weak self] (response, error) in
            if let error = error {
                print("Erreur de recherche: \(error.localizedDescription)")
                return
            }
            guard let mapItems = response?.mapItems else { return }
            self?.addresses = mapItems.map { mapItem in
                Address(
                    streetAddress: mapItem.placemark.name ?? "Inconnu",
                    city: mapItem.placemark.locality ?? "Inconnu",
                    formattedAddress: mapItem.placemark.title ?? "Inconnu",
                    state: mapItem.placemark.administrativeArea ?? "",
                    zipCode: mapItem.placemark.postalCode ?? "",
                    country: mapItem.placemark.country ?? "",
                    lng: mapItem.placemark.coordinate.longitude,
                    lat: mapItem.placemark.coordinate.latitude
                )
               
            }
        }
    }
    
    func selectAddress(_ address: Address) {
        selectedAddress = address
        print(selectedAddress ?? "")
        isAddressSelected = true
        addresses = [] // Masque les suggestions après la sélection
    }

    func resetAddressSelection() {
        selectedAddress = nil
        isAddressSelected = false // Réinitialise l'état
    }
}
