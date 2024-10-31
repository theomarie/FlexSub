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
}
