//
//  Notice.swift
//  FlexSub
//
//  Created by apprenant103 on 28/10/2024.

import SwiftUI

struct ReviewView: View {
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        
        let averageRating = reviews.reduce(0) { $0 + $1.rating } / Double(reviews.count)
        NavigationStack {
            List {
                HStack {
                    UserPicture(user: $userData.user)
                    Spacer()
                    VStack(alignment: .center){
                        HStack() {
                            Text("\(String(format: "%.1f", averageRating))")
                                .font(.largeTitle)
                        }
                        // Affichage des étoiles
                        HStack(spacing: 0) {
                            ForEach(1..<Int(averageRating.rounded()) + 1, id: \.self) { _ in
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                            }
                            if averageRating != averageRating.rounded() {
                                Image(systemName: "star.lefthalf.fill")
                                    .foregroundColor(.yellow)
                            }
                        }
                        Text("(\(reviews.count))")
                    }
                    Spacer()
                }
                
                
                Section(header: Text("Avis")) {
                    ForEach(reviews) { review in
                        
                        HStack {
                            Image(review.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                            VStack(alignment: .leading) {
                                Text(review.activity)
                                    .font(.headline)
                                Text(review.name)
                                    .font(.subheadline)
                                    .foregroundColor(.brown)
                                Text(review.comment)
                                    .font(.caption)
                            }
                            Spacer()
                            
                            
                            ForEach(1..<Int(review.rating) + 1 ) { _ in
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
        
