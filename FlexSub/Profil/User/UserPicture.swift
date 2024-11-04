//
//  UserPicture.swift
//  FlexSub
//
//  Created by apprenant103 on 28/10/2024.
//

//Image de l'utilisateur

import SwiftUI
import PhotosUI

struct UserPicture: View {
    
    @Binding var user: User
    @State private var picture: UIImage?
    @State private var refreshView = false
    
    var body: some View {
        VStack {
            if let picture = picture {
                Image(uiImage: picture)
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
        }
        .onAppear {
            picture = user.picture
            refreshView = true
            refreshView.toggle()
            
        }
        .onChange(of: user.picture) { _, newPicture in
            picture = newPicture
        }
        
    }
}
        




// UserPicture(image: $userData.inputImage) sert a appelé l'mage de l'utilisateur
