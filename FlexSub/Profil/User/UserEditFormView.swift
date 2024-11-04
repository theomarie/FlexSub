//
//  EditUser.swift
//  FlexSub
//
//  Created by apprenant103 on 25/10/2024.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

//struct UserEditFormView: View {
//    @EnvironmentObject var userData: UserData
//    @Environment(\.dismiss) var dismiss
//    @State private var showImagePicker = false
//    @State private var isShowingImagePicker = false
//    @State private var inputImage: UIImage?
//    @State private var username: String = ""
//    @State private var email: String = ""
//
//    var body: some View {
//        List {
//            VStack {
//                UserPicture()
//
//            }
//
//            TextField("Nom d'utilisateur", text: $username)
//                .onAppear {
//                    username = userData.user?.username ?? ""
//                }
//            TextField("Email", text: $email)
//                .onAppear {
//                    email = userData.user?.email ?? ""
//                }
//            
//        }
//        .navigationTitle("Modifier le profil")
//        .toolbar {
//            ToolbarItem(placement: .navigationBarTrailing) {
//                Button("Enregistrer") {
//                    
//                    userData.user!.username = username
//                    userData.user!.email = email
//
//                    dismiss()
//                }
//            }
//            ToolbarItem(placement: .navigationBarLeading) {
//                Button("Annuler") {
//                    dismiss()
//                }
//            }
//        }
//    }
//}
//


struct UserEditFormView: View {
    @Binding var user: FlexSub.User
    @EnvironmentObject var userData: UserData
    @Environment(\.dismiss) var dismiss
    @State private var showImagePicker = false
    @State private var inputImage: UIImage?
    @State private var selectedImage: UIImage?
    @State private var isLoading = false
  
    
    
    var body: some View {
        
        VStack {
            if let selectedImage = selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth: 120, maxHeight: 120)
                    .clipShape(Circle())
            } else if let userPicture = user.picture {
                Image(uiImage: userPicture)
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth: 120, maxHeight: 120)
                    .clipShape(Circle())
            } else {
                Image(systemName: "person.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth: 120, maxHeight: 120)
                    .clipShape(Circle())
            }
        
            Button("Changer d'image") {
                showImagePicker = true
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $inputImage)
                    .environmentObject(userData)
            }
            .onChange(of: inputImage) { _, newValue in
                if let newValue = newValue {
                    user.picture = newValue
                }
            }
            
            
            
            TextField("Nom d'utilisateur", text: $user.username)
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 3)
                .padding(.bottom, 10)
            TextField("Email", text: $userData.user.email)
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
            
            Button("Enregistrer") {
                let db = Firestore.firestore()
                let userRef = db.collection("users").document(user.id)
                dismiss()
                    
                userRef.updateData([
                    "username": user.username,
                    "email": user.email,
                    "password": user.password,
                    "firstName": user.firstName,
                    "lastName": user.lastName,
                    "address": user.address
                    
                ]) { error in
                    if let error = error {
                        print("Erreur lors de la mise à jour Firestore : \(error)")
                    } else {
                        Auth.auth().currentUser?.sendEmailVerification(beforeUpdatingEmail: user.email) { error in
                            if let error = error {
                                print("Erreur lors de l'envoi de l'email de vérification : \(error)")
                            } else {
                                print("Email de vérification envoyé avec succès !")

                                // 2. Mettre à jour le mot de passe (si nécessaire)
                                Auth.auth().currentUser?.updatePassword(to: user.password) { error in
                                    isLoading = false
                                    if let error = error {
                                        print("Erreur lors de la mise à jour du mot de passe : \(error)") // Gérez l'erreur
                                    } else {
                                        print("Informations de connexion mises à jour avec succès !")
                                        userData.user = user
                                        dismiss()
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .foregroundStyle(.white)
            .padding()
            .background(Color.blue.opacity(1))
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .padding()
    }
}
