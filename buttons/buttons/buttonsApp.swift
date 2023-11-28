//
//  buttonsApp.swift
//  buttons
//
//  Created by Girish Verma on 2023-11-17.
//

import SwiftUI
import FirebaseCore
import Foundation

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}



struct GlobalSettings {
    static var uuid: String {
        get {
            UserDefaults.standard.string(forKey: "_id") ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "_id")
        }
    }
}

@main
struct YourApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    init() {
        // Check if the UUID exists
        if UserDefaults.standard.string(forKey: "_id") == nil {
            // Create a new UUID and save it
            var newUUID = UUID().uuidString
            newUUID = String(newUUID.prefix(8))
            UserDefaults.standard.set(newUUID, forKey: "_id")
        }
    }

    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }
    }
}
