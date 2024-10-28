//
//  ActivityConfirmationView.swift
//  FlexSub
//
//  Created by Apprenant 108 on 28/10/2024.
//

import SwiftUI

struct ActivityConfirmationView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Confirmez votre choix")
                .font(.headline)
            
            Text("Vous êtes en train de rejoindre l'activité : ")
            
            // Activité passée en paramètre 
            Text("Titre, date, prix")
                .font(.headline)
            
            VStack{
                ValidationButtonView(text: "Continuer vers le paiement", action: {})
            }
            .cornerRadius(10)
            .padding()
            
            Button {
                dismiss()
            } label: {
                Text("Annuler")
            }
        }
    }
}

#Preview {
    ActivityConfirmationView()
}
