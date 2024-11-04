//
//  UserViewModel.swift
//  FlexSub
//
//  Created by Theo Marie on 31/10/2024.
//

import SwiftUI
import FirebaseFirestore

// MARK: - UserViewModel
@Observable class UserViewModel  {
    var user: User?
    var isLoading: Bool = false
    var errorMessage: String?
    var profileImage: UIImage?
    var cachedImage: UIImage?

    
    func fetchUser(byId id: String) async {
        isLoading = true
        errorMessage = nil
        
        let result = await User.fetchUserById(id: id)
        DispatchQueue.main.async {
            self.isLoading = false
            switch result {
            case .success(let user):
                self.user = user
            case .error(let error):
                self.errorMessage = error.localizedDescription
            case .loading, .idle:
                break
            }
        }
    }
    /*
    func loadProfileImage() async -> UIImage {
            if let cachedImage = cachedImage {
                return cachedImage
            }
            
            guard let profileImageUrl = profileImageUrl, let url = URL(string: profileImageUrl) else {
                return UserImage.defaultImage ?? UIImage()
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let image = UIImage(data: data)
                self.cachedImage = image
                return image ?? UserImage.defaultImage ?? UIImage()
            } catch {
                print("Erreur de chargement de l'image :", error.localizedDescription)
                return UserImage.defaultImage ?? UIImage()
            }
        }
     */
}
