//
//  EditUser.swift
//  FlexSub
//
//  Created by apprenant103 on 25/10/2024.
//

import SwiftUI
import Firebase
import FirebaseAuth
import PhotosUI
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
    
    
    @State var user: User // Déclarer user comme @State
    @Environment(\.dismiss) var dismiss
    @Environment(AuthViewModel.self) var viewModel
    @State private var showImagePicker = false
    @State private var isPresentingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var selectedImage: UIImage?
    @State var selectedItem: PhotosPickerItem?
    @State var profileImage: Image?
    @State var uiImage: UIImage?
    
    
    
    var body: some View {
        VStack {
            if let user = viewModel.currentUser {
                PhotosPicker(selection: $selectedItem, matching: .images) {
                    if let profileImage {
                        profileImage
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 120)
                            .clipShape(Circle())
                    } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 120, height: 120)
                            .foregroundColor(.gray)
                    }
                }
                .onChange(of: selectedItem) { newItem in
                    Task {
                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
                            if let uiImage = UIImage(data: data)
                            {
                                self.uiImage = uiImage
                                profileImage = Image(uiImage: uiImage)
                                
                                // Mettre à jour user.userImage avec les données de l'image
                                user.userImage = UserImage(image: uiImage, url: nil) // Assurez-vous que UserImage a un initialiseur qui prend une UIImage
                                
                                // Télécharger l'image vers Firebase Storage et mettre à jour user.profileImageUrl (à implémenter)
                                // ...
                            }
                        }
                    }
                }
                //            .onChange(of: inputImage) { _, newValue in
                //                if let newValue = newValue {
                //                    if let imageData = newValue.jpegData(compressionQuality: 0.8) {
                //                        user.userImage = imageData
                //                        selectedImage = newValue
                //                    }
                //                }
                //            }
                
                TextField("Nom d'utilisateur", text: $user.username)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 3)
                    .padding(.bottom, 10)
                TextField("Email", text: $user.email) // Utiliser $user.email
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 3)
                    .padding(.bottom, 10)
                
                //                SecureField("Mot de passe", text: $user.password)
                //                    .padding()
                //                    .background(Color.white)
                //                    .cornerRadius(12)
                //                    .shadow(radius: 3)
                //                    .padding(.bottom, 10)
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
            }
            
            Button("Enregistrer") {
                let db = Firestore.firestore()
                let userRef = db.collection("users").document(user.id)
                dismiss()
                
                userRef.updateData([
                    "username": user.username,
                    "email": user.email,
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
                            }
                        }
                    }
                }
                
                
                
                
            }
            .onAppear {
                // Initialiser user avec les données de l'utilisateur actuel
                guard let firebaseUser = Auth.auth().currentUser else {
                    // Gérer le cas où l'utilisateur n'est pas connecté
                    return
                }
                
                user = User(
                    id: firebaseUser.uid,
                    username: firebaseUser.displayName ?? "",
                    email: firebaseUser.email ?? "",
                    firstName: "", // Remplacez par la valeur appropriée
                    lastName: "", // Remplacez par la valeur appropriée
                    profileImageUrl: "", // Remplacez par la valeur appropriée
                    address: "" // Remplacez par la valeur appropriée
                )
            }
        }
    }
}

