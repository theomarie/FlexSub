//
//  FlexSubApp.swift
//  FlexSub
//
//  Created by Theo Marie on 23/10/2024.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
      
      if let firebaseApp = FirebaseApp.app() {
             print("Firebase a bien été initialisé avec \(firebaseApp.name)")
         } else {
             print("Échec de l'initialisation de Firebase")
         }
    return true
  }
}

@main
struct FlexSubApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

  var body: some Scene {
    WindowGroup {
      NavigationView {
        //ContentView()
          RegisterView()
      }
    }
  }
}
