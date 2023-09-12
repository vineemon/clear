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
    @State var isPopoverPresented = false
    @State var isEditTimelinesActive = false
    @State var isCreateTimelinesActive = false
    @State var isSettingsActive = false
    @State var isLoggedOut = false
    
    var body: some View {
        NavigationStack {
            VStack{
                HStack {
                    Spacer()
                    Text("Learn Cloud Concepts").font(.system(size: 24)).bold()
                    Spacer()
                    Menu {
                        Button {
                            self.isCreateTimelinesActive = true
                        } label: {
                            Label("Create Timeline", systemImage: "plus.square.fill.on.square.fill")
                        }
                        Button {
                            self.isEditTimelinesActive = true
                        } label: {
                            Label("Edit Timelines", systemImage: "pencil.circle.fill")
                        }
                        Button {
                            self.isSettingsActive = true
                        } label: {
                            Label("Settings", systemImage: "gearshape.fill")
                        }
                        Button {
                            self.isLoggedOut = true
                        } label: {
                            Label("Logout", systemImage: "rectangle.portrait.and.arrow.right.fill")
                        }
                    } label: {
                        Label("", systemImage: "line.3.horizontal.decrease")
                    }
                }
                List(cloudProjects, id: \.title) { cloudProject in
                    CardView(cloudProject: cloudProject)
                        .listRowBackground(cloudProject.theme.mainColor)
                }.scrollContentBackground(.hidden)
            }
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
    var difficulty: String
    var theme: Theme
}

extension CloudProject {
    static let sampleData: [CloudProject] =
    [
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
