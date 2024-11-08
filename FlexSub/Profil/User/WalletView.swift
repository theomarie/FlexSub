//
//  WalletView.swift
//  FlexSub
//
//  Created by apprenant103 on 08/11/2024.
//
import SwiftUI

struct WalletView: View {
    @ObservedObject var authViewModel: AuthViewModel

    var body: some View {
        if let wallet = authViewModel.currentUser?.wallet {
            VStack {
    

                List {
                    Section(header: Text("Cartes bleues")) {
                        ForEach(wallet.cartesBleues) { carte in
                            CarteBleueView(carte: carte)
                        }
                    }

                    Section(header: Text("Transactions")) {
                        ForEach(wallet.transactions) { transaction in
                            TransactionRow(transaction: transaction)
                        }
                    }
                }
            }
        } else {
            Text("Le portefeuille n'est pas disponible.")
        }
    }
}
