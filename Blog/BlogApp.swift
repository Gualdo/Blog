//
//  BlogApp.swift
//  Blog
//
//  Created by Eduardo David De La Cruz Marrero on 1/10/21.
//

import SwiftUI
import Firebase

@main
struct BlogApp: App {
    
    // Initializing Firebase...
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
