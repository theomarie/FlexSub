//
//  FlexSubApp.swift
//  FlexSub
//
//  Created by Theo Marie on 23/10/2024.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth


// AppDelegate pour initialiser Firebase
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct FlexSubApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
   

    
    var body: some Scene {
        
        WindowGroup {
            AuthSecureScreen()
                .environment(AuthViewModel())
                .environment(ActivitiesViewModel())
               
        }
    }
}
