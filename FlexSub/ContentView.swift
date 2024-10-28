//
//  ContentView.swift
//  FlexSub
//
//  Created by Theo Marie on 23/10/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var userData = UserData() 

    var body: some View {
        UserView()
            .environmentObject(userData)
    }
}
   

#Preview {
    ContentView()
}
