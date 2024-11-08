//
//  FirebaseManager.swift
//  FlexSub
//
//  Created by Theo Marie on 29/10/2024.
//

import FirebaseFirestore
import FirebaseStorage


class FirebaseManager {
    static let shared = FirebaseManager() // Singleton instance
    let db = Firestore.firestore()        // Firestore instance

    private init() {} // Empêche l'initialisation extérieure
}
