//
//  ContentView.swift
//  FlexSub
//
//  Created by Theo Marie on 23/10/2024.
//

import SwiftUI




struct ContentView: View {
    @Environment(AuthViewModel.self) var authViewModel
    var body: some View {
        VStack {
         
                AddressSearchView()
           
            Text("Hello, world!")
                .font(.largeTitle)
                .padding()

            Button(action: {
                authViewModel.logout()  // Appel de la méthode de déconnexion
            }) {
                Text("Se déconnecter")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(8)
            }
            .padding()
        }
    }
}

#Preview {
    
    ContentView()
}
