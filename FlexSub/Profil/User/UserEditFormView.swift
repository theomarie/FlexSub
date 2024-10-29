//
//  EditUser.swift
//  FlexSub
//
//  Created by apprenant103 on 25/10/2024.
//

import SwiftUI

struct UserEditFormView: View {
    @Binding var user: User
    @Environment(\.dismiss) var dismiss
    @State private var showImagePicker = false

    var body: some View {
        VStack {
            UserPicture(image: $user.picture)

            TextField("Nom d'utilisateur", text: $user.username)
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 3)
                .padding(.bottom, 10)
            TextField("Email", text: $user.email)
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 3)
                .padding(.bottom, 10)
            SecureField("Mot de passe", text: $user.password)
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 3)
                .padding(.bottom, 10)
            TextField("Prénom", text: $user.firstName)
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 3)
                .padding(.bottom, 10)
            TextField("Nom", text: $user.lastName)
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 3)
                .padding(.bottom, 10)
            TextField("Adresse", text: $user.address)
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 3)
                .padding(.bottom, 10)

            Button(action: {
                dismiss()
            }) {
                Text("Enregistrer")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: 200)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .shadow(radius: 5)
            }
            .padding(.top, 20)
        }
        .padding()
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $user.picture)
                .environmentObject(UserViewModel())
        }
    }
}

