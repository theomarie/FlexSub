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
    
    @EnvironmentObject var userData: UserData
    @Environment(AuthViewModel.self) var viewModel
    @State private var showEditForm = false
    @State private var refreshView = false
    
    var body: some View {
        VStack {
            HStack{
                Spacer()
                    UserPicture(user: $userData.user)
                VStack{
                    Text(" \(userData.user.username)")
                    Text("\(userData.user.email)")
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
            .navigationDestination(isPresented: $showEditForm) {
                UserEditFormView(user: .constant(userData.user))
            }
        }
        
        .navigationTitle("Profil")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showEditForm = true
                }) {
                    Image(systemName: "pencil")
                }
            }
        }
        .onAppear {
            refreshView = true
            refreshView.toggle()
            userData.objectWillChange.send()
        }
        .onChange(of: refreshView) { _, _ in
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
