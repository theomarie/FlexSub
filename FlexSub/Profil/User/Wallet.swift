//
//  Wallet.swift
//  FlexSub
//
//  Created by apprenant103 on 08/11/2024.
//
import SwiftUI
import DataDetection

struct Wallet: Identifiable {
    let id = UUID()
    var balance: Double
    var transactions: [Transaction] = [Transaction(amount: 8, date: Date() , description: "Séance Venom"),
                                       Transaction(amount: 7.90, date: Date(), description: "Basic Fit")]
    var cartesBleues: [CarteBleue] = [CarteBleue(numeroCarte: "4265906545876543", dateExpiration: "10/28", titulaire: "AMAYYAH ABDELGHANI", typeCarte: "VISA")]
}

struct CarteBleue: Identifiable {
    let id = UUID()
    var numeroCarte: String
    var dateExpiration: String
    var titulaire: String
    var typeCarte: String // ex: "Visa", "Mastercard"
}
