//
//  UserData.swift
//  FlexSub
//
//  Created by apprenant103 on 25/10/2024.
//


import SwiftUI

import SwiftUI

struct UserView: View {
    @StateObject var userData = UserData() 
    @State private var isEditing = false

    var body: some View {
        NavigationView {
            HStack {
                
                if let picture = userData.user.picture {
                    Image(uiImage: picture)
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .frame(minWidth: 100, maxWidth: 200)
                        .shadow(radius: 7)
                } else {
                    Image(systemName: "person.circle") // Image par défaut
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray, lineWidth: 4))
                        .frame(minWidth: 100, maxWidth: 150)
                        .shadow(radius: 7)
                }

                VStack {
                    Text(userData.user.username)
                        .font(.title)
                    Text(userData.user.email)
                        .font(.subheadline)
                        .fontWeight(.light)
                    
                   
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
            .padding()
        }
    }
}


#Preview {
    UserView()
}
