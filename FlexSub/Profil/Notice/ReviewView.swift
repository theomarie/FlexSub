//
//  Notice.swift
//  FlexSub
//
//  Created by apprenant103 on 28/10/2024.
//


import SwiftUI

struct ReviewsView: View {
    
    @State var user: User

    var body: some View {
        NavigationView {
            List {
                HStack {
                    UserPicture(image: $user.picture)
                    Spacer()
                    VStack {
                        Text(user.username)
                            .font(.title3)
                            .bold()

                        // Calcul de la moyenne des notes
                        let averageRating = user.reviews.reduce(0) { $0 + $1.rating } / Double(user.reviews.count)
                        Text("(\(String(format: "%.1f", averageRating)))")

                        // Affichage des étoiles
                        HStack(spacing: 0) {
                            ForEach(1..<Int(averageRating.rounded()) , id: \.self) { _ in
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                            }
                            if averageRating != averageRating.rounded() {
                                Image(systemName: "star.lefthalf.fill")
                                    .foregroundColor(.yellow)
                            }
                        }
                        Text("(\(user.reviews.count))")
                    }
                }

                Section(header: Text("Avis")) {
                    ForEach(user.reviews) { review in
                        HStack {
                            Text(review.comment)
                            Text("Note : ")
                            ForEach(1..<Int(review.rating) + 1) { _ in
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
