//
//  TransactionRow.swift
//  FlexSub
//
//  Created by apprenant103 on 08/11/2024.
//

import SwiftUI

struct TransactionRow: View {
    let transaction: Transaction

    var body: some View {
        HStack {
            Text("\(transaction.amount, specifier: "%.2f")€")
            Spacer()
            Text(transaction.date, style: .date)
            Spacer()
            Text(transaction.description)
        }
    }
}
