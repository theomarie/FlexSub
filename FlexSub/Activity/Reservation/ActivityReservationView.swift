//
//  ReservationView.swift
//  FlexSub
//
//  Created by Apprenant 82 on 28/10/2024.
//

import SwiftUI
import MapKit

struct ActivityReservationView: View {
    @State var reservationViewModel: ActivityReservationViewModel
    @Environment(\.dismiss) private var dismiss
    @Environment(AuthViewModel.self) var authViewModel
    let userId: String
    @State var userViewModel = UserViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Chargement de l'utilisateur
                if userViewModel.userState.isLoading {
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
                        Text(reservationViewModel.activity.address.streetAddress )
                            .font(.headline)
                        
                        // Bouton pour ouvrir dans Google Maps
                        Button(action: {
                            openInGoogleMaps(for: reservationViewModel.activity.address)
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
                    
                    Text(reservationViewModel.activity.title)
                        .font(.headline)
                    
                    Text("Date et heure : \(formatDate(reservationViewModel.activity.date))")
                        .font(.subheadline)
                    
                    Text("Lieu : \(reservationViewModel.activity.address.formattedAddress)")
                        .font(.subheadline)
                    
                    Text("Prix : \(String(format: "%.2f", reservationViewModel.activity.price))€")
                        .font(.subheadline)
                        .bold()
                }
                .padding(.top, 8)
                
                Divider()
                
                Button(action: {
                    Task {
                        await joinActivity()
                    }
                }) {
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
    
    func joinActivity() async {
        guard let user = userViewModel.user else { return }
        guard let user2 = authViewModel.currentUser else {return}
        await reservationViewModel.joinActivity(userID: userId, activityID: reservationViewModel.activity.id)
        
        // Vérifiez si l'activité a été rejointe avec succès et fermez la vue
        
        if case .success = reservationViewModel.activitiyState {
            print("Success")
            let user1 = ChatParticipant(id: user.id, name: user.username, avatarURL: user.profileImageUrl, isCurrentUser: false)
            
            let userMessaging2 = ChatParticipant(id: user2.id, name: user2.username, avatarURL: user2.profileImageUrl, isCurrentUser: false)
            
            
            Conversation.createChatBetweenUsers(user1: user1, user2: userMessaging2, activityTitle: reservationViewModel.activity.title, activityId: reservationViewModel.activity.id)
            
          
                } else {
                    print("Erreur : L'URL de l'image de profil est invalide.")
                }
             
                
               
                dismiss() // Ferme la vue si la requête est réussie
            }
        }
    
    
    // Fonction pour ouvrir l'adresse dans Google Maps
    func openInGoogleMaps(for address: Address) {
        let addressQuery = address.formattedAddress.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        if let url = URL(string: "https://www.google.com/maps/search/?api=1&query=\(addressQuery)") {
            UIApplication.shared.open(url)
        }
    }



#Preview {
    ActivityReservationView(reservationViewModel: ActivityReservationViewModel(activity: cinemaActivity, activitieState: .idle), userId: "345YyQQQH6QUvbd06USvbyFPApJ3")
}

