//
//  UserPicture.swift
//  FlexSub
//
//  Created by apprenant103 on 28/10/2024.
//

//Image de l'utilisateur

import SwiftUI


struct UserPicture: View {
    @Binding var image: UIImage?
    @State private var showImagePicker = false

    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 7)
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
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $image)
        }
    }
}
