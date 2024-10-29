//
//  UserData.swift
//  FlexSub
//
//  Created by apprenant103 on 25/10/2024.
//
//Vue profil


import SwiftUI

import SwiftUI

struct UserView: View {
    @StateObject private var userViewModel = UserViewModel()
    @State private var isEditing = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    UserPicture(image: $userViewModel.user.picture)
                    
                    VStack {
                        Text(userViewModel.user.username)
                            .font(.title)
                        
                        
                        NavigationLink(destination: ReviewsView(user: userViewModel.user)) {
                            Text("Voir les avis")
                        }
                    }
                }
                Spacer()
                Button(action: AuthViewModel().logout ){
                    Text("Se déconnecter")
                }
            }
            
            .navigationTitle("Profil")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isEditing = true
                    }) {
                        Image(systemName: "pencil")
                    }
                }
            }
            .padding()
            .sheet(isPresented: $isEditing) {
                UserEditFormView(user: $userViewModel.user)
            }
        }
    }
}


