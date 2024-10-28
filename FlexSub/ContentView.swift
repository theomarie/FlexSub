//
//  ContentView.swift
//  FlexSub
//
//  Created by Theo Marie on 23/10/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack{
            TabView {
                UserView()
                    .tabItem {
                        Label("Profil", systemImage: "list.dash")
                    }
            }
        }
    }
}
   

#Preview {
    ContentView()
}
