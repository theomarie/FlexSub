//
//  Category.swift
//  FlexSub
//
//  Created by Theo Marie on 23/10/2024.
//

enum Category: String, Categories {
    case all = "Tous"
    case cinema = "Cinéma"
    case sport = "Sport"
    case museum = "Musée"
    case concert = "Concert"

    var name: String {
        return self.rawValue
    }

    static var allCategories: [Category] {
        return [.all, .cinema, .sport, .museum, .concert]
    }
}


