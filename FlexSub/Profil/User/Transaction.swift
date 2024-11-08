//
//  Transaction.swift
//  FlexSub
//
//  Created by apprenant103 on 08/11/2024.
//
import SwiftUI

struct Transaction: Identifiable {
    let id = UUID()
    var amount: Double
    var date: Date
    var description: String
}
