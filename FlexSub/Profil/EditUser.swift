//
//  EditUser.swift
//  FlexSub
//
//  Created by apprenant103 on 25/10/2024.
//

import SwiftUI

struct UserEditFormView: View {
    @Binding var user: User
    @Binding var inputImage: UIImage?
    @Environment(\.dismiss) var dismiss
    @State private var showImagePicker = false

    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            VStack {
                if let image = inputImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 8))
                        .shadow(radius: 10)
                        .onTapGesture {
                            showImagePicker = true
                        }
                } else {
                    Image(systemName: "person.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray, lineWidth: 4))
                        .shadow(radius: 7)
                        .onTapGesture {
                            showImagePicker = true
                        }
                }

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
//            .sheet(isPresented: $showImagePicker) {
//                ImagePicker(image: $inputImage) 
//            }
        }
    }
}
