//
//  App195App.swift
//  App195
//
//  Created by Вячеслав on 9/14/23.
//

import SwiftUI
import FirebaseCore
import ApphudSDK
import Amplitude

class AppDelegate: NSObject, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Apphud.start(apiKey: "app_CTCwgwU5aqmE7Nwpb81RYMthYFJWjE")
        Amplitude.instance().initializeApiKey("48adf3f19daef66c593e9495855caa22")
        
        FirebaseApp.configure()
        
        return true
    }
}

@main
struct App195App: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        
        WindowGroup {
            
            NavigationView {
                
                ContentView()
            }
        }
    }
}
