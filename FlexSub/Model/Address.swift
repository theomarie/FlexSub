//
//  Adress.swift
//  FlexSub
//
//  Created by apprenant103 on 24/10/2024.
//
import SwiftUI
import MapKit

struct Address: Identifiable, Codable, Equatable, Hashable {
    var id = UUID()
    let streetAddress: String
    let city: String
    let formattedAddress: String
    var state: String = ""
    let zipCode: String
    var country: String = ""
    let lng: Double
    let lat: Double
    
    // Propriété calculée pour obtenir la coordonnée CLLocationCoordinate2D
       var coordinate: CLLocationCoordinate2D {
           return CLLocationCoordinate2D(latitude: lat, longitude: lng)
       }
       
       // Propriété calculée pour obtenir l'emplacement MKMapItem
       var mapItem: MKMapItem {
           let placemark = MKPlacemark(coordinate: coordinate)
           return MKMapItem(placemark: placemark)
       }
    
}






// Code peut etre pour plus tard


//class Address: Identifiable{
//    var id = UUID()
//    var streetAddress: String
//    var city: String
//    var formattedAddress: String
//    var state: String
//    var zipCode: String
//    var country: String
//    var lng: Double
//    var lat: Double
//    
//    
//    init (id : UUID = UUID(), streetAddress: String, city: String, formattedAddress: String, state: String, zipCode: String, country: String, lng: Double, lat: Double) {
//        
//        self.id = id
//        self.streetAddress = streetAddress
//        self.city = city
//        self.formattedAddress = formattedAddress
//        self.state = state
//        self.zipCode = zipCode
//        self.country = country
//        self.lng = lng
//        self.lat = lat
//    }
//}
