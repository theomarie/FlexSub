//
//  SampleDataActivity.swift
//  FlexSub
//
//  Created by Theo Marie on 28/10/2024.
//

import Foundation

extension Activity {
     static func sampleData() -> [Activity] {
       let users = User.sampleData
         guard !users().isEmpty else { return [] }
         
         return [
                     Activity(
                         title: "Basic fit séance",
                         owner: users().randomElement()!.id,
                         participant: nil ,
                         price: 5.0,
                         date: Date(),
                         category: .sport,
                         address: Address(
                             streetAddress: "123 Main St",
                             city: "Paris",
                             formattedAddress: "123 Main St, Paris, France",
                             state: "Ile-de-France",
                             zipCode: "75001",
                             country: "France",
                             lng: 2.3522,
                             lat: 48.8566
                         )
                     ),
                     Activity(
                         title: "Séance du joker 2",
                         owner: users().randomElement()!.id,
                         participant: nil,
                         price: 3.0,
                         date: Date().addingTimeInterval(86400), // Activité le lendemain
                         category: .cinema,
                         address: Address(
                             streetAddress: "456 Elm St",
                             city: "Lyon",
                             formattedAddress: "456 Elm St, Lyon, France",
                             state: "Auvergne-Rhône-Alpes",
                             zipCode: "69000",
                             country: "France",
                             lng: 4.8357,
                             lat: 45.764
                         )
                     ),
                     Activity(
                         title: "Séance Moi moche et Méchant",
                         owner: users().randomElement()!.id,
                         participant: nil,
                         price: 3.0,
                         date: Date().addingTimeInterval(86400), // Activité le lendemain
                         category: .cinema,
                         address: Address(
                             streetAddress: "456 Elm St",
                             city: "Lyon",
                             formattedAddress: "456 Elm St, Lyon, France",
                             state: "Auvergne-Rhône-Alpes",
                             zipCode: "69000",
                             country: "France",
                             lng: 4.8357,
                             lat: 45.764
                         )
                     ),
                 ]
         
    }
}
