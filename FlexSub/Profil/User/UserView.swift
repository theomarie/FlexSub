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
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var showEditForm = false
    @State private var refreshView = false

   

    var body: some View {
        VStack {
            // Vérifier si l'utilisateur est chargé
            if let user = authViewModel.currentUser {
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
                    authViewModel.logout()
                }
                .toolbar {
                    NavigationLink(destination: UserEditView(authViewModel: authViewModel)) {
                        Label("Modifier le profil", systemImage: "pencil")
                    }
                }
                .navigationTitle("Profil")
            
            }
        }
        .onAppear {
            refreshView = true
            
        }
        .onChange(of: authViewModel.currentUser) { _, _ in
                refreshView.toggle()
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
    

