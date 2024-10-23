//
//  RegisterVIew.swift
//  FlexSub
//
//  Created by Theo Marie on 23/10/2024.
//

import SwiftUI
import Firebase
import FirebaseAuth


struct RegisterView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var errorMessage: String = ""
    @State private var isShowingError = false
    @State private var isSuccess = false

    var body: some View {
        VStack(spacing: 20) {
            TextField("Email", text: $email)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            SecureField("Mot de passe", text: $password)
            SecureField("Confirmer mot de passe", text: $confirmPassword)
                

            Button(action: {
                registerUser()
            }) {
                Text("S'inscrire")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }

            if isShowingError {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
            
            if isSuccess {
                Text("Inscription réussie!")
                    .foregroundColor(.green)
                    .padding()
            }
        }
        .padding()
    }

    private func registerUser() {
        guard password == confirmPassword else {
            errorMessage = "Les mots de passe ne correspondent pas."
            isShowingError = true
            return
        }
        
        AuthManager.shared.registerUser(email: email, password: password) { result in
            switch result {
            case .success:
                isSuccess = true
                errorMessage = ""
            case .failure(let error):
                errorMessage = "Erreur : \(error.localizedDescription)"
                isShowingError = true
            }
        }
    }
}

#Preview {
    RegisterView()
}
