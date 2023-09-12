//
//  ClearApp.swift
//  Clear
//
//  Created by Vineet Nadella on 9/8/23.
//

import SwiftUI

@main
struct ClearApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(cloudProjects: [
                CloudProject(title: "Database",
                           time: 400,
                             difficulty: "Medium",
                           theme: .seafoam),
                CloudProject(title: "Load Balancer",
                           time: 5,
                             difficulty: "Hard",
                           theme: .poppy),
                CloudProject(title: "Caching",
                           time: 5,
                             difficulty: "Hard",
                           theme: .poppy)
            ])
        }
    }
}
