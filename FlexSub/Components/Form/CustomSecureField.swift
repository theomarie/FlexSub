//
//  CustomSecureField.swift
//  FlexSub
//
//  Created by Theo Marie on 29/10/2024.
//

import Foundation
import SwiftUI

struct CustomSecureField: View {
    let label: String
    let placeholder: String
    let icon: String
    @Binding var text: String
    var validation: (String) -> Bool
    @State private var isValid: Bool = true
    @State private var showPassword: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .foregroundColor(.gray)
            
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.gray)
                
                if showPassword {
                    TextField(placeholder, text: $text)
                        .textInputAutocapitalization(.never)
                } else {
                    SecureField(placeholder, text: $text)
                }
                
                Button(action: { showPassword.toggle() }) {
                    Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                        .foregroundColor(.gray)
                }
                
                if !text.isEmpty {
                    Image(systemName: isValid ? "checkmark.circle.fill" : "xmark.circle.fill")
                        .foregroundColor(isValid ? .green : .red)
                }
            }
            .padding()
            .onChange(of: text) {
                isValid = validation(text)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(text.isEmpty ? Color.gray : (isValid ? Color.green : Color.red), lineWidth: 1)
            )
        }
    }
}
