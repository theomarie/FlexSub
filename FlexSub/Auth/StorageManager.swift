//
//  StorageManager.swift
//  FlexSub
//
//  Created by Theo Marie on 30/10/2024.
//

import Foundation
import SwiftUI
import FirebaseStorage



class StorageManager {
    static let shared = StorageManager()
    private init() {}
    
    private let storage = Storage.storage().reference()
    
    func uploadProfileImage(_ image: UIImage?, userId: String) async throws -> String? {
        // Si pas d'image, retourner l'URL de l'image par défaut
        guard let image = image else {
            return "gs://flexsub-edf76.appspot.com/userDefault.png" // URL de votre image par défaut
        }
        
        // Compression de l'image
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            throw NSError(domain: "Image compression failed", code: -1)
        }
        
        // Créer une référence unique pour l'image
        let imageRef = storage.child("profile_images/\(userId).jpg")
        
        // Upload
        let _ = try await imageRef.putDataAsync(imageData)
        
        // Récupérer l'URL
        let downloadURL = try await imageRef.downloadURL()
        return downloadURL.absoluteString
    }
}
