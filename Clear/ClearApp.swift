//
//  ClearApp.swift
//  Clear
//
//  Created by Vineet Nadella on 9/8/23.
//

import SwiftUI
import Firebase

@main
struct ClearApp: App {
    @StateObject var firestoreManager = FirestoreManager()
    
    init() {
            FirebaseApp.configure()
        }
    
    var body: some Scene {
        WindowGroup {
//            ContentView(cloudProjects: [
//                CloudProject(title: "Database",
//                             progress: 0.0,
//                             difficulty: "Medium",
//                           theme: .sky),
//                CloudProject(title: "Load Balancer",
//                             progress: 0.0,
//                             difficulty: "Hard",
//                           theme: .sky),
//                CloudProject(title: "Caching",
//                             progress: 0.0,
//                             difficulty: "Hard",
//                           theme: .sky)
//            ])
            LoginView().environmentObject(firestoreManager)
        }
    }
}
