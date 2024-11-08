//
//  UserViewModel.swift
//  FlexSub
//
//  Created by apprenant103 on 29/10/2024.
//

//import SwiftUI
//import Combine
//
//class UserData: ObservableObject {
//    @Published var user: User?
//
//    init(viewModel: AuthViewModel) {
//        self.user = viewModel.currentUser // Correction ici
//
//        viewModel.currentUser // Correction ici
//            .sink { [weak self] newUser in
//                self?.user = newUser
//            }
//            .store(in: &cancellables)
//    }
//
//    private var cancellables = Set<AnyCancellable>()
//}
