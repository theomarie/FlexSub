//
//  Categories.swift
//  FlexSub
//
//  Created by Theo Marie on 23/10/2024.
//

protocol Categories {
    var name: String { get }
    static var allCategories: [Self] { get }
}
