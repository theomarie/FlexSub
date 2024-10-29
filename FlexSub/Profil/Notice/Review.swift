//
//  Review.swift
//  FlexSub
//
//  Created by apprenant103 on 28/10/2024.
//


import SwiftUI

struct Review: Identifiable, Codable {
    var id: UUID = UUID()
    let authorId: User.ID
    let userId: User.ID
    let rating: Int
    let comment: String
    let date: Date
}


