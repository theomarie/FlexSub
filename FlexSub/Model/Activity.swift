//
//  Activity.swift
//  FlexSub
//
//  Created by apprenant103 on 24/10/2024.
//

import SwiftUI

struct Activity: Identifiable {
    let id = UUID()
    var title: String
    var status: Status = .published
    var owner: User.ID
    var participant: User.ID?
    var price: Double = 0
    var date: Date
    var category: Category = .all // Revoir plus tard 
    var etablissementId: Etablishement.ID?
}
