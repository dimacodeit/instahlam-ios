//
//  InstahlamApp.swift
//  Instahlam
//
//  Created by dmitry-s on 05.04.2022.
//

import SwiftUI
import Firebase
   
@main
struct InstahlamApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
