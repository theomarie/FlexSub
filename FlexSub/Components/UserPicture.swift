//
//  UserPicture.swift
//  FlexSub
//
//  Created by Theo Marie on 31/10/2024.
//
import SwiftUI


struct UserPicture: View {
    let user: User
    
    var body: some View {
            VStack {
                if let profileImage = user.cachedImage {
                    Image(uiImage: profileImage)
                        .resizable()
                        .scaledToFit()
                        
                        .clipShape(Circle())
                } else {
                    ProgressView()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .task {
                            _ = await user.loadProfileImage()
                        }
                }
            }
        }
}


