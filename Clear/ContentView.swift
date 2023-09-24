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
    @State var isSettingsActive = false
    @State var isLoggedOut = false
    @State private var selectedCourse: CloudCourse = .dataPartitioning
    
    var body: some View {
//        NavigationStack{
            VStack {
                List(cloudProjects, id: \.title) { cloudProject in
                    CardView(cloudProject: cloudProject)
                        .listRowBackground(cloudProject.theme.mainColor)
                }.scrollContentBackground(.hidden)
                HStack {
                    Text("Add Course: ")
                    Picker("Add Course: ", selection: $selectedCourse) {
                        ForEach(CloudCourse.allCases) { course in
                            Text(course.cloudProject.title)
                                .tag(course.cloudProject)
                        }
                    }
                }
                Button(action: submitEvent) {
                    Text("Submit").padding().frame(width: 200)
                }.frame(alignment: .center).background(alignment: .center, content: {
                    LinearGradient(
                        colors: [Color(red: 0.4627, green: 0.8392, blue: 1.0), .blue],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .frame(width: 200, height: 40, alignment: .center)
                }
                ).frame(width: 200, height: 40, alignment: .center).cornerRadius(50).foregroundColor(.white)
            }.padding().navigationTitle(Text("Learn Cloud Concepts")).navigationBarBackButtonHidden(true).navigationBarTitleDisplayMode(.inline).toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Menu {
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
            }.navigationDestination(isPresented: $isSettingsActive, destination: {
                SettingsView()
            }).navigationDestination(isPresented: $isLoggedOut, destination: {
                LoginView().environmentObject(FirestoreManager()).navigationBarBackButtonHidden(true).navigationBarTitleDisplayMode(.inline)
            })
//        }
    }
    
    func submitEvent() {
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(cloudProjects: CloudProject.sampleData)
    }
}

enum CloudCourse: String, CaseIterable, Identifiable {
    case dataPartitioning, indexes, proxies
    var id: Self { self }
}

extension CloudCourse {
    var cloudProject: CloudProject {
        switch self {
        case .dataPartitioning: return CloudProject(title: "Data Partitioning",
                                                    progress: 0.0,
                                                      difficulty: "Hard",
                                                    theme: .poppy)
        case .indexes: return CloudProject(title: "Indexes",
                                           progress: 0.0,
                                         difficulty: "Hard",
                                         theme: .poppy)
        case .proxies: return CloudProject(title: "Proxies",
                                           progress: 0.0,
                                             difficulty: "Hard",
                                           theme: .poppy)
        }
    }
}

struct CloudProject: Hashable {
    var title: String
    var progress: Float
    var difficulty: String
    var theme: Theme
}

extension CloudProject {
    static let sampleData: [CloudProject] =
    [
        CloudProject(title: "Database",
                     progress: 0.0,
                     difficulty: "Medium",
                   theme: .seafoam),
        CloudProject(title: "Load Balancer",
                     progress: 0.0,
                     difficulty: "Hard",
                   theme: .poppy),
        CloudProject(title: "Caching",
                     progress: 0.0,
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
