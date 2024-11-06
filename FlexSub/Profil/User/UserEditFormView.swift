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
    
    
    @State var user: User // Déclarer user comme @State
    @Environment(\.dismiss) var dismiss
    @Environment(AuthViewModel.self) var viewModel
    @State private var showImagePicker = false
    @State private var isPresentingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var selectedImage: UIImage?
    
    
    
    var body: some View {
        VStack {
            if let profileImage = user.profileImageUrl, let profileImageURL = URL(string: profileImage) {
                AsyncImage(url: profileImageURL)
                    .scaledToFit()
                    .frame(minWidth: 100, maxHeight: 100)
                    .clipShape(Circle())
            } else {
                Image(systemName: "person.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth: 100, maxHeight: 100)
                    .clipShape(Circle())
            }
            
            Button("Modifier l'image") {
                isPresentingImagePicker = true
            }
            .sheet(isPresented: $isPresentingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            .onChange(of: inputImage) { _, newValue in
                if let newValue = newValue {
                   
                    if newValue.jpegData(compressionQuality: 0.8) != nil {
                        // Mettre à jour l'URL de l'image dans Firebase Storage (à implémenter)
                        
                        
                        user.profileImageUrl = "nouvelle-url-de-l-image"
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
        }
        
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
       

