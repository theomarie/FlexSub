//
//  EtablissementView.swift
//  FlexSub
//
//  Created by Apprenant 82 on 25/10/2024.
//

import SwiftUI
struct EtablissementView: View {
    var etablissement: Etablissement

    var body: some View {
        HStack {
            if let image = etablissement.image {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .cornerRadius(8)
            }
            
            VStack(alignment: .leading) {
                Text(etablissement.name)
                    .font(.headline)
                
                Text("\(etablissement.address.street), \(etablissement.address.city) \(etablissement.address.postalCode)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    ActivitiesListView()
}
