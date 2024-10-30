//
//  UserData.swift
//  FlexSub
//
//  Created by apprenant103 on 25/10/2024.
//
//Vue profil


import SwiftUI

struct UserView: View {
    @StateObject var userData = UserData() 
    @State private var isEditing = false

    var body: some View {
        NavigationView {
            HStack {
              //  UserPicture(image: $userData.user.picture) 

                VStack {
                    Text(userData.user.username)
                        .font(.title)
                    Text(userData.user.email)
                        .font(.subheadline)
                        .fontWeight(.light)

                    NavigationLink(destination: ReviewsView().environmentObject(userData)) {
                        Text("Voir les avis")
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
                    UserEditFormView(user: $userData.user)
                        .environmentObject(userData) 
                }
            }
        }
    }
}


#Preview {
    UserView()
}
