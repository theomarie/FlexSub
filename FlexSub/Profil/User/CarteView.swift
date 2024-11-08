//
//  CarteView.swift
//  FlexSub
//
//  Created by apprenant103 on 08/11/2024.
//
import SwiftUI

struct CarteBleueView: View {
    let carte: CarteBleue

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading, endPoint: .trailing))
                .frame(width: 300, height: 200)
                .padding()

            VStack(alignment: .leading) {
                HStack {
                    Text("CREDIT CARD")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                       
                    Spacer()
                    Text(carte.typeCarte) // Afficher le type de carte (Visa, Mastercard, etc.)
                        .font(.system(size: 25, weight: .bold))
                        .foregroundColor(.white)
                }
                .padding(.top)

                Spacer()
               

                Text(carte.titulaire)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)

                HStack {
                    Text("EXPIRE")
                        .font(.caption)
                        .foregroundColor(.white)
                    Text("FIN")
                        .font(.caption)
                        .foregroundColor(.white)
                    Text(carte.dateExpiration)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white)
                }
                .padding()
               
            }
            .padding(25)
        }
    }
}
