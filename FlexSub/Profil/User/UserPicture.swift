//
//  UserPicture.swift
//  FlexSub
//
//  Created by apprenant103 on 28/10/2024.
//

//Image de l'utilisateur

import SwiftUI
import Firebase
import FirebaseAuth
import PhotosUI

//extension View {
//    func userPicture(user: User) -> some View {
//        self.modifier(UserPicture(user: user))
//    }
//}

// Un modificateur pour encapsuler la logique de UserPicture

struct UserPicture: View {
    @Environment(AuthViewModel.self) var viewModel
    @State private var isPresentingImagePicker = false
    @State private var inputImage: UIImage?
    @State var profileImage: Image?
    @State var uiImage: UIImage?
   
    
    var body: some View {
        VStack {
            
            
            if let user = viewModel.currentUser {
                if let profileImage = user.profileImageUrl, let profileImageURL = URL(string: profileImage) {
                    AsyncImage(url: profileImageURL) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                    } placeholder: {
                        ProgressView()
                            .frame(width: 150, height: 150)
                    }
                } else {
                    Image(systemName: "person.circle")
                    
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.gray)
                }
            }
        }
        .onTapGesture {
            isPresentingImagePicker = true // Ouvrir ImagePicker au toucher
        }
    }
}
                
                //                Button("Modifier l'image") {
                //                    isPresentingImagePicker = true
                //                }
                //                .sheet(isPresented: $isPresentingImagePicker) {
                //                    ImagePicker(image: $inputImage)
                //                }
//                    .onChange(of: inputImage) { _, newValue in
//                        if let newValue = newValue, let imageData = newValue.jpegData(compressionQuality: 0.8) {
//                            // 1. Mettre à jour l'image de l'utilisateur dans user.userImage
//                            user.userImage = imageData
//                            
//                            // 2. Mettre à jour l'URL de l'image dans Firebase Storage
//                            Task {
//                                if let newProfileImageUrl = try? await viewModel.uploadProfileImage(imageData, userId: user.id) {
//                                    // 3. Mettre à jour l'URL de l'image dans user.profileImageUrl
//                                    user.profileImageUrl = newProfileImageUrl
//                                }
//                            }
//                        }
//                    }
            
        
