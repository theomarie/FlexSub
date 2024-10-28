//
//  ValidationButtonView.swift
//  FlexSub
//
//  Created by Apprenant 108 on 28/10/2024.
//

import SwiftUI

struct ValidationButtonView: View {
    
    var text : String
    var action: () -> Void
    
    var body: some View {
        Button {
            //
        } label: {
            HStack{
                Spacer()
                Text(text)
                    .foregroundStyle(.white)
                    .padding()
                Spacer()
            }
            
        }
        .background(.blue)

    }
}

#Preview {
    ValidationButtonView(text: "Valider", action: {})
}

#Preview {
    AddActivityFormView()
}
