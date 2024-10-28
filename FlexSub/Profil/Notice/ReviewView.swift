//
//  Notice.swift
//  FlexSub
//
//  Created by apprenant103 on 28/10/2024.
//

import SwiftUI

struct ReviewsView: View {
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        NavigationView {
            List {
                
                HStack {
                    UserPicture(image: $userData.inputImage)
                    Spacer()
                    VStack{
                        Text(userData.user.username)
                            .font(.title)
                            .bold()
                        let averageRating = Double(userData.user.reviews.reduce(0) { $0 + $1.rating }) / Double(userData.user.reviews.count)
                        Text(" \(String(format: "%.1f", averageRating))")
                        HStack(alignment: .center) {
                            ForEach(1..<Int(averageRating.rounded()) + 1) { _ in
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                            }
                        }
                        Text("(\(userData.user.reviews.count))")
                    }
                }
               
                
                    // Affichage des avis
                    Section(header: Text("Avis")) { // Ajout d'un titre de section
                        ForEach(userData.user.reviews) { review in
                            HStack {
                                Text(review.comment)
                                Text("Note : ")
                                ForEach(1..<review.rating + 1) { _ in
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                }
                            }
                        }
                    }
                }
            }
        }
    }


