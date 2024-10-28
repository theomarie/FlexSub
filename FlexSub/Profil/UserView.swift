//
//  UserData.swift
//  FlexSub
//
//  Created by apprenant103 on 25/10/2024.
//


import SwiftUI

struct UserView: View {
    @ObservedObject var userData = UserData() 
    @State private var isEditing = false

    var body: some View {
        NavigationView {
            VStack {
                if let picture = userData.user.picture {
                    Image(uiImage: picture)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 7)
                }

                Text(userData.user.username)
                    .font(.title)
                Text(userData.user.email)
                    .font(.subheadline)
                Text("\(userData.user.firstName) \(userData.user.lastName)")
                    .font(.headline)
                Text(userData.user.address)
                    .font(.subheadline)
                Spacer()
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
                UserEditFormView(user: $userData.user, inputImage: $userData.inputImage) 
            }
        }
    }
}
