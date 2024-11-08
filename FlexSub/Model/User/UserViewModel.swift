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
    private let userRepository = FirebaseUserRepository()
    var userState: RequestState<User> = .idle
    var errorMessage: String?

    
    
    func fetchUser(byId id: String) async {
          userState = .loading
          userState = await userRepository.fetchUserById(id: id)
          user = userState.value
      }
 
}
