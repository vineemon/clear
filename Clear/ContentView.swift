//
//  ContentView.swift
//  Clear
//
//  Created by Vineet Nadella on 9/8/23.
//

import SwiftUI
import Foundation

struct ContentView: View {
    let cloudProjects: [CloudProject]
    var body: some View {
        VStack{
            Text("Learn Cloud Concepts").font(.system(size: 24)).bold()
            List(cloudProjects, id: \.title) { cloudProject in
                CardView(cloudProject: cloudProject)
                    .listRowBackground(cloudProject.theme.mainColor)
            }.navigationTitle("Learn Cloud Concepts").scrollContentBackground(.hidden)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(cloudProjects: CloudProject.sampleData)
    }
}

struct CloudProject {
    var title: String
    var time: Int
    var theme: Theme
}

extension CloudProject {
    static let sampleData: [CloudProject] =
    [
        CloudProject(title: "Database",
                   time: 400,
                   theme: .yellow),
        CloudProject(title: "Load Balancer",
                   time: 5,
                   theme: .orange),
        CloudProject(title: "Caching",
                   time: 5,
                   theme: .poppy)
    ]
}

enum Theme: String {
    case bubblegum
    case buttercup
    case indigo
    case lavender
    case magenta
    case navy
    case orange
    case oxblood
    case periwinkle
    case poppy
    case purple
    case seafoam
    case sky
    case tan
    case teal
    case yellow

    var accentColor: Color {
        switch self {
        case .bubblegum, .buttercup, .lavender, .orange, .periwinkle, .poppy, .seafoam, .sky, .tan, .teal, .yellow: return .black
        case .indigo, .magenta, .navy, .oxblood, .purple: return .white
        }
    }
    
    var mainColor: Color {
        Color(rawValue)
    }
}
