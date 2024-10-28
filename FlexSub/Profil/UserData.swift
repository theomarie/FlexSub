//
//  UserData.swift
//  FlexSub
//
//  Created by apprenant103 on 25/10/2024.
//

import SwiftUI

class UserData: ObservableObject {
    @Published var user: User = User(username: "", email: "", password: "", firstName: "", lastName: "", address: "")
    @Published var inputImage: UIImage?
}
