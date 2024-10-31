//
//  RegisterView.swift
//  FlexSub
//
//  Created by Theo Marie on 29/10/2024.
//

import SwiftUI
import Firebase
import FirebaseAuth
import PhotosUI

struct RegisterView: View {
    // MARK: - Properties
    @Environment(AuthViewModel.self) var authViewModel
    @Environment(\.dismiss) var dismiss
    @State private var selectedItem: PhotosPickerItem?
    @State private var profileImage: Image?
    @State private var uiImage: UIImage?
    
    // Form fields
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var username = ""
    @State private var firstName = ""
    @State private var lastName = ""
   // @State private var address = ""
    
    
    // Validation states
    @State private var isEmailValid = false
    @State private var isPasswordValid = false
    @State private var doPasswordsMatch = false
    @State private var isShowingError = false
    @State private var errorMessage = ""
    
    // MARK: - Validation Logic
    private var isFormValid: Bool {
        isEmailValid &&
        isPasswordValid &&
        doPasswordsMatch &&
        !username.isEmpty &&
        !firstName.isEmpty &&
        !lastName.isEmpty
       // !address.isEmpty
    }
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Profile Image Picker
                PhotosPicker(selection: $selectedItem, matching: .images) {
                    if let profileImage {
                        profileImage
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 120)
                            .clipShape(Circle())
                    } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 120, height: 120)
                            .foregroundColor(.gray)
                    }
                }
                .onChange(of: selectedItem) {
                    Task {
                        if let data = try? await selectedItem?.loadTransferable(type: Data.self) {
                            if let uiImage = UIImage(data: data) {
                                self.uiImage = uiImage
                                profileImage = Image(uiImage: uiImage)
                            }
                        }
                    }
                }
                
                // Form Fields
                Group {
                    CustomTextField(
                        label: "Email",
                        placeholder: "Votre Email",
                        icon: "envelope.fill",
                        keyboardType: .emailAddress,
                        text: $email,
                        validation: { email in
                            let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
                            let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegex)
                            isEmailValid = emailPred.evaluate(with: email)
                            return isEmailValid
                        }
                    )
                    CustomTextField(
                        label: "Nom d'utilisateur",
                        placeholder: "Votre nom d'utilisateur",
                        icon: "person",
                        text: $username,
                        validation: { !$0.isEmpty }
                    )
                    CustomTextField(
                        label: "Nom",
                        placeholder: "Votre nom",
                        icon: "person.text.rectangle.fill",
                        text: $lastName,

                        validation: { !$0.isEmpty }
                    )
                    
                    CustomTextField(
                        label: "Prénom",
                        placeholder: "Votre prénom",
                        icon: "person.text.rectangle",
                        text: $firstName,
                        validation: { !$0.isEmpty }
                    )
                    
                    CustomSecureField(
                        label: "Mot de passe",
                        placeholder: "Votre mot de passe",
                        icon: "lock",
                        text: $password,
                        validation: { password in
                            isPasswordValid = password.count >= 8
                            doPasswordsMatch = password == confirmPassword
                            return isPasswordValid
                        }
                    )
                    
                    CustomSecureField(
                        label: "Confirmer le mot de passe",
                        placeholder: "Confirmez votre mot de passe",
                        icon: "lock.shield",
                        text: $confirmPassword,
                        validation: { confirmPwd in
                            doPasswordsMatch = confirmPwd == password
                            return doPasswordsMatch
                        }
                    )
                    
                    
                    
                   
                  
                }
                
                // Register Button
                Button(action: registerUser) {
                    if authViewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    } else {
                        Text("S'inscrire")
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(isFormValid ? Color.blue : Color.gray)
                .foregroundColor(.white)
                .cornerRadius(10)
                .disabled(!isFormValid || authViewModel.isLoading)
                
                if isShowingError {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
                
              
            }
            .padding()
        }
        .navigationTitle("Inscription")
    }
    
    // MARK: - Actions
    private func registerUser() {
        let user = User(id: UUID().uuidString, username: username, email: email,  firstName: firstName, lastName: lastName, profileImageUrl: "", address: "")
        
      
        Task {
            let result = await authViewModel.registerUser(email: email, password: password, profileImage: uiImage, user: user)
            
            switch result {
            case .success(let user):
                // Mettez à jour l'état pour indiquer que l'inscription a réussi
                self.authViewModel.currentUser = user
                self.isShowingError = false
                dismiss()
            case .error(let error):
                // Affichez le message d'erreur
                self.isShowingError = true
                self.errorMessage = error.localizedDescription
            case .loading:
                // loading state
                break
            case .idle:
                break
            }
        }
    }
}


// MARK: - Preview
struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RegisterView()
                .environment(AuthViewModel())
        }
    }
}
