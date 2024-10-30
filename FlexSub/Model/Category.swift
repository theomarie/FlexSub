//
//  Category.swift
//  FlexSub
//
//  Created by Theo Marie on 23/10/2024.
//

enum Category: String,CaseIterable, Identifiable, Categories, Codable {
    case all = "Tous"
    case cinema = "Cinéma"
    case sport = "Sport"
    case museum = "Musée"
    case concert = "Concert"
    
    var id: String { self.rawValue }

    var name: String {
        return self.rawValue
    }

    static var allCategories: [Category] {
        return [.all, .cinema, .sport, .museum, .concert]
    }
}


