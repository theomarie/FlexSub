//
//  RegisterVIew.swift
//  FlexSub
//
//  Created by Theo Marie on 23/10/2024.
//

import SwiftUI
import Firebase
import FirebaseAuth


struct AuthView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isRegistering: Bool = false
    @State private var errorMessage: String = ""
    @State private var isShowingError = false
    @Environment(AuthViewModel.self) var authViewModel


    var body: some View {
        if (authViewModel.isLoggedIn) {
        } else {
            
            VStack(spacing: 20) {
                Text(isRegistering ? "S'inscrire" : "Se connecter")
                    .font(.largeTitle)
                    .bold()
                
                TextField("Email", text: $email)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                SecureField("Mot de passe", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Button(action: {
                    isRegistering ? registerUser() : loginUser()
                }) {
                    Text(isRegistering ? "S'inscrire" : "Se connecter")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                
                if isShowingError {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
                
                Button(action: {
                    isRegistering.toggle()
                }) {
                    Text(isRegistering ? "Déjà un compte ? Se connecter" : "Pas de compte ? S'inscrire")
                        .fontWeight(.light)
                        .foregroundColor(.blue)
                }
                
                
                
            }
            .padding()
        }
    }
        
        
        private func loginUser() {
            AuthManager.shared.loginUser(email: email, password: password) { result in
                switch result {
                case .success(_):
                    print("Connexion réussie")
                    authViewModel.isLoggedIn = true
                case .failure(let error):
                    errorMessage = error.localizedDescription
                    isShowingError = true
                }
            }
        }
        
        private func registerUser() {
            authViewModel.register(email: email, password: password)
            }
        
    }

#Preview {
    AuthView()
        .environment(AuthViewModel())
}
