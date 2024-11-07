//
//  UserData.swift
//  FlexSub
//
//  Created by apprenant103 on 25/10/2024.
//
//Vue profil


import SwiftUI
import FirebaseAuth


import SwiftUI

struct UserView: View {
    @Environment(AuthViewModel.self) var viewModel
    @State private var showEditForm = false
    

   

    var body: some View {
        VStack {
            // Vérifier si l'utilisateur est chargé
            if let user = viewModel.currentUser {
                HStack {
                    Spacer()
                    UserPicture() // Passer l'utilisateur à UserPicture
                    VStack {
                        Text(" \(user.username)")
                        Text("\(user.email)")
                        NavigationLink(destination: ReviewView()) {
                            Text("Voir les avis")
                        }
                    }
                    Spacer()
                }
                Spacer()

                Button("Déconnexion") {
                    viewModel.logout()
                }
                .toolbar {
                    NavigationLink(destination: UserEditFormView(user: user)) {
                        Label("Modifier le profil", systemImage: "pencil")
                    }
                }
                .navigationTitle("Profil")
            } else {
                // Afficher un indicateur de chargement pendant le chargement de l'utilisateur
                ProgressView()
            }
        }
        .onAppear {
            // Charger l'utilisateur depuis viewModel
        }
    }
}
        
        
        
        //struct UserView: View {
        //    @StateObject private var userViewModel = UserViewModel()
        //    @State private var isEditing = false
        //    var user = Auth.auth().currentUser
        //
        //    var body: some View {
        //            VStack {
        //                HStack {
        //                    UserPicture(image: $userViewModel.user.picture)
        //                    Spacer()
        //                    VStack {
        //                        Text(userViewModel.user.username)
        //                            .font(.title)
        //
        //
        //
        //                        NavigationLink(destination: ReviewsView(user: userViewModel.user)) {
        //                            Text("Voir les avis")
        //                        }
        //                    }
        //                    Spacer()
        //                }
        //                Spacer()
        //                Button(action: AuthViewModel().logout ){
        //                    Text("Se déconnecter")
        //                }
        //            }
        //
        //            .navigationTitle("Profil")
        //            .toolbar {
        //                ToolbarItem(placement: .navigationBarTrailing) {
        //                    Button(action: {
        //                        isEditing = true
        //                    }) {
        //                        Image(systemName: "pencil")
        //                    }
        //                }
        //            }
        //            .padding()
        //            .sheet(isPresented: $isEditing) {
        //                UserEditFormView(user: $userViewModel.user)
        //            }
        //        }
        //    }
        //
        //
        //
    

