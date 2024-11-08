
//  EditUser.swift
//  FlexSub
//
//  Created by apprenant103 on 25/10/2024.
//

import SwiftUI

struct UserEditView: View {
    
    
    @Environment(\.dismiss) var dismiss
    //    @Environment(AuthViewModel.self) var viewModel
    @State private var showImagePicker = false
    @State var inputImage: Image?
    @ObservedObject var authViewModel: AuthViewModel
    @State private var userBinding: Binding<User>?
    @State private var profileImage: UIImage?
    @State var refreshView = false
    
    var body: some View {
        

            
            VStack {
                if let user = authViewModel.currentUser {
                    if let image = inputImage {
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(minWidth: 120, maxHeight: 120)
                            .clipShape(Circle())
                            .onTapGesture {
                                showImagePicker = true
                            }
                    } else {
                       
                        Image(systemName: "person.circle")
                            .resizable()
                            .scaledToFill()
                            .frame(minWidth: 120, maxHeight: 120)
                            .clipShape(Circle())
                            .shadow(radius:7)
                            .onTapGesture {
                                showImagePicker = true
                            }
                    }
                    let userBinding = Binding<User>(
                        get: { user },
                        set: { authViewModel.updateUser($0) })
                
                    
                    TextField("Nom d'utilisateur", text: userBinding.username)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(radius: 3)
                        .padding(.bottom, 10)
                    
                    TextField("Email", text: userBinding.email)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(radius: 3)
                        .padding(.bottom, 10)
                    
                    TextField("Prénom", text: userBinding.firstName)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(radius: 3)
                        .padding(.bottom, 10)
                    
                    TextField("Nom", text: userBinding.lastName)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(radius: 3)
                        .padding(.bottom, 10)
                    
                    TextField("Adresse", text: userBinding.address)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(radius: 3)
                        .padding(.bottom, 10)
                    
                    Button(action: {
//                        saveChanges()
                        dismiss()
                    }) {
                        Text("Enregistrer")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: 200)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                            .shadow(radius: 5)
                    }
                    .padding(.top, 20)
                    
                }
                    
            }
        
            
            
            .sheet(isPresented: $showImagePicker) {
                if authViewModel.currentUser != nil {
                    ImagePicker(uiImage: $profileImage, viewModel: authViewModel)
                        .padding()
                }
            }
            .padding()
            .onAppear {
                    refreshView = true // Initialiser la variable d'état
                }
        
        }
    
    }


            
            
//            func saveChanges() {
//                //user.picture = userData.inputImage
//            }
        
    

