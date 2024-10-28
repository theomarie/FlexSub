//
//  Address.swift
//  FlexSub
//
//  Created by Apprenant 82 on 25/10/2024.
//

import Foundation
import SwiftUI

struct Address {
    var street: String
    var city: String
    var postalCode: String
}

struct Etablissement: Identifiable {
    var id = UUID()
    var name: String
    var address: Address
    var image: Image?
}

let etablissementPathe = Etablissement(
    name: "Cinéma Pathé",
    address: Address(street: "1 Avenue Pathé", city: "Paris", postalCode: "75000"),
    image: Image("Pathe")
)

let etablissementBasicFit = Etablissement(
    name: "Basic Fit",
    address: Address(street: "3 Rue du Vieux Colombier", city: "Paris", postalCode: "75006"),
    image: Image("BasicFit")
)

let etablissementMadParis = Etablissement(
    name: "MAD Paris",
    address: Address(street: "107 Rue de Rivoli", city: "Paris", postalCode: "75001"),
    image: Image("MadParis")
)

let etablissementJeuDePaume = Etablissement(
    name: "Jeu de Paume",
    address: Address(street: "1 Pl. de la Concorde", city: "Paris", postalCode: "75008"),
    image: Image("Jeudepaume")
)

let etablissementTempMachines = Etablissement(
    name: "Le Temp Machines",
    address: Address(street: "Parvis Miles Davis", city: "Joué-lès-Tours", postalCode: "37300"),
    image: Image("TempMachines")
)
