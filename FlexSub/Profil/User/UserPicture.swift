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

struct UserPicture: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var picture: UIImage?
    @State private var refreshView = false
    
    
    var body: some View {
        VStack {
            if let picture = picture {
                Image(uiImage: picture)
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth: 100, maxHeight: 120)
                    .clipShape(Circle())
            } else {
                Image(systemName: "person.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth: 100, maxHeight: 120)
                    .clipShape(Circle())
            }
        }
        .onAppear {
                refreshView = true // Initialiser la variable d'état
            }
        .onReceive(authViewModel.$currentUser) { user in
            picture = user?.picture
        }
    }
}
