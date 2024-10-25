//
//  HomeScreen.swift
//  FlexSub
//
//  Created by Theo Marie on 24/10/2024.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct HomeScreen: View {
    @State var authViewModel = AuthViewModel()
    
    
    var body: some View {
            Group {
                if authViewModel.isLoading {
                    // Affiche un indicateur de chargement lorsque isLoading est vrai
                    ProgressView("Chargement...")
                        .progressViewStyle(CircularProgressViewStyle())
                        
                } else {
                    // Lorsque le chargement est terminé, on affiche soit la Home, soit AuthView
                    if authViewModel.isLoggedIn {
                        NavigationView {
                            ContentView(authViewModel: authViewModel)
                        }
                    } else {
                        AuthView(authViewModel: authViewModel)
                    }
                }
            }
            .onAppear {
                authViewModel.checkIfUserIsLoggedIn() // Vérifie l'état de connexion lorsque la vue apparaît
            }
        }
    }
