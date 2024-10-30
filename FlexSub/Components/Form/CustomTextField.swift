//
//  CustomTextField.swift
//  FlexSub
//
//  Created by Theo Marie on 29/10/2024.
//

import SwiftUI

struct CustomTextField: View {
    let label: String
    let placeholder: String
    let icon: String
    var keyboardType: UIKeyboardType = .default
    @Binding var text: String
    var validation: (String) -> Bool
    @State private var isValid: Bool = true
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .foregroundColor(.gray)
            
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.gray)
                TextField(placeholder, text: $text)
                    .keyboardType(keyboardType)
                    .textInputAutocapitalization(.never)
                    .onChange(of: text) {
                        isValid = validation(text)
                    }
                
                if !text.isEmpty {
                    Image(systemName: isValid ? "checkmark.circle.fill" : "xmark.circle.fill")
                        .foregroundColor(isValid ? .green : .red)
                }
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(text.isEmpty ? Color.gray : (isValid ? Color.green : Color.red), lineWidth: 1)
            )
        }
    }
}
