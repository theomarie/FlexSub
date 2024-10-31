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
    var user: User

    var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
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
                       // voir dans la list activites comment gerer les images
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(activity.address.streetAddress)
                                .font(.headline)
                            
                            // Bouton pour ouvrir Google Maps
                            Button(action: openInMaps) {
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
        
       
    }
    
    // Fonction pour ouvrir l'emplacement dans Google Maps
    func openInMaps() {
       /*
        if let url = URL(string: "https://www.google.com/maps/search/?api=1&query=\(address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")") {
            UIApplication.shared.open(url)
        }
        */
    
    }

   
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }



#Preview {
    ActivityReservationView(activity: cinemaActivity, user: User(id: "ddshu514541", username: "mariethéo", email: "theo@gmail.com", password: "123456", firstName: "Théo", lastName: "Marie", profileImageUrl: "", address: "10 boulevard marechal juin , 14000, Caen"))
}

