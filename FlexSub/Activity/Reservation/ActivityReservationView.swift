//
//  ReservationView.swift
//  FlexSub
//
//  Created by Apprenant 82 on 28/10/2024.
//

import SwiftUI
import MapKit

struct ActivityReservationView: View {
    let activity: Activity
    //@Environment(AuthViewModel.self) var authViewModel
    let userId: String
    @State var userViewModel = UserViewModel()
    
    var body: some View {
           ScrollView {
               VStack(alignment: .leading, spacing: 16) {
                   // Chargement de l'utilisateur
                    if userViewModel.isLoading {
                    ProgressView("Chargement de l'utilisateur...")
                } else if let errorMessage = userViewModel.errorMessage {
                    Text("Erreur : \(errorMessage)").foregroundColor(.red)
                } else if let user = userViewModel.user {
                    UserPicture(user: user)

                    VStack(alignment: .leading) {
                        Text("Proposé par : \(user.username)")
                            .font(.headline)
                    }
                    .padding(.leading, 8)
                }
                   
                   Divider()
                   
                   // Image de l'établissement et informations
                   HStack(alignment: .top) {
                       VStack(alignment: .leading, spacing: 4) {
                           Text(activity.address.streetAddress)
                               .font(.headline)
                           
                           // Bouton pour ouvrir dans Google Maps
                           Button(action: {
                               openInGoogleMaps(for: activity.address)
                           }) {
                               Text("Ouvrir dans Google Maps")
                                   .font(.subheadline)
                                   .foregroundColor(.blue)
                           }
                       }
                   }
                   
                   Divider()
                   
                   // Détails de l'activité
                   VStack(alignment: .leading, spacing: 8) {
                       Text("Détails de l'activité")
                           .font(.title2)
                           .bold()
                       
                       Text(activity.title)
                           .font(.headline)
                       
                       Text("Date et heure : \(formatDate(activity.date))")
                           .font(.subheadline)
                       
                       Text("Lieu : \(activity.address.formattedAddress)")
                           .font(.subheadline)
                       
                       Text("Prix : \(String(format: "%.2f", activity.price))€")
                           .font(.subheadline)
                           .bold()
                   }
                   .padding(.top, 8)
                   
                   Divider()
                   
                   Button(action: {}) {
                       Text("Rejoindre l'activité")
                           .font(.headline)
                           .frame(maxWidth: .infinity)
                           .padding()
                           .background(Color.blue)
                           .foregroundColor(.white)
                           .cornerRadius(10)
                   }
                   .padding(.top, 16)
               }
               .padding()
           }
           .onAppear {
               Task {
                   await userViewModel.fetchUser(byId: userId)
               }
           }
       }
       
       // Fonction pour formater la date
       func formatDate(_ date: Date) -> String {
           let formatter = DateFormatter()
           formatter.dateStyle = .medium
           formatter.timeStyle = .short
           return formatter.string(from: date)
       }
       
       // Fonction pour ouvrir l'adresse dans Google Maps
       func openInGoogleMaps(for address: Address) {
           let addressQuery = address.formattedAddress.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
           if let url = URL(string: "https://www.google.com/maps/search/?api=1&query=\(addressQuery)") {
               UIApplication.shared.open(url)
           }
       }
   }


#Preview {
    ActivityReservationView(activity: cinemaActivity, userId: "345YyQQQH6QUvbd06USvbyFPApJ3")
}

