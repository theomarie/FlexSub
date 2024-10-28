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
                        id:  UUID().uuidString, title: "Basic fit séance",
                         ownerId: users().randomElement()!.id,
                         participant: nil ,
                         price: 5.0,
                         date: Date(),
                         category: .sport,
                         address: Address(
                             streetAddress: "Basic-Fit Marseille Avenue de la Capelette II",
                             city: "Marseille",
                             formattedAddress: "Basic-Fit Marseille Avenue de la Capelette II, Marseille, France",
                             state: "Auvergne-Rhône-Alpes",
                             zipCode: "13010",
                             country: "France",
                             lng: 5.4066515,
                             lat: 43.2805138
                         )
                     ),
                     Activity(
                        id:  UUID().uuidString, title: "Séance du joker 2",
                         ownerId: users().randomElement()!.id,
                         participant: nil,
                         price: 3.0,
                         date: Date().addingTimeInterval(86400), // Activité le lendemain
                         category: .cinema,
                         address: Address(
                             streetAddress: "Pathé la joliette",
                             city: "Marseille",
                             formattedAddress: "54, rue de Chanterac, Marseille, France",
                             state: "Auvergne-Rhône-Alpes",
                             zipCode: "13002",
                             country: "France",
                             lng:  5.3677639,
                             lat: 43.3123055
                         )
                     ),
                     Activity(
                        id:  UUID().uuidString, title: "Séance Moi moche et Méchant",
                        ownerId: users().randomElement()!.id,
                         participant: nil,
                         price: 3.0,
                         date: Date().addingTimeInterval(86400), // Activité le lendemain
                         category: .cinema,
                         address: Address(
                            streetAddress: "Pathé la joliette",
                            city: "Marseille",
                            formattedAddress: "54, rue de Chanterac, Marseille, France",
                            state: "Auvergne-Rhône-Alpes",
                            zipCode: "13002",
                            country: "France",
                            lng:  5.3677639,
                            lat: 43.3123055
                        )
                     ),
                 ]
         
    }
}
