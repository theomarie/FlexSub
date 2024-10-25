//
//  Etablishment.swift
//  FlexSub
//
//  Created by apprenant103 on 24/10/2024.
//

import SwiftUI

struct Etablishement: Identifiable {
    let id = UUID() 
    let name: String
    let address: Address
    let image: Image?
}
