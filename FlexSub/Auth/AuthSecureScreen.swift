//
//  HomeScreen.swift
//  FlexSub
//
//  Created by Theo Marie on 24/10/2024.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct AuthSecureScreen: View {
    @Environment(AuthViewModel.self) var authViewModel: AuthViewModel
    
    
    var body: some View {
        NavigationStack() {
            Group {
                if authViewModel.isLoading {
                    // Affiche un indicateur de chargement lorsque isLoading est vrai
                    ProgressView("Chargement...")
                        .progressViewStyle(CircularProgressViewStyle())
                    
                } else {
                    // Lorsque le chargement est terminé, on affiche soit la Home, soit AuthView
                    if authViewModel.isLoggedIn {
                        
                            ContentView()
                        
                    } else {
                        AuthLoginView()
                    }
                }
            }
            .onAppear {
                authViewModel.checkIfUserIsLoggedIn() // Vérifie l'état de connexion lorsque la vue apparaît
            }
        }
        }
    }
