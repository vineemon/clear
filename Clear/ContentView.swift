//
//  ContentView.swift
//  Clear
//
//  Created by Vineet Nadella on 9/8/23.
//

import SwiftUI
import Foundation

struct ContentView: View {
    @EnvironmentObject var firestoreManager: FirestoreManager
    @State var isSettingsActive = false
    @State var addCoursesOpen = false
    @State var isLoggedOut = false
    @State var isProfileOpen = false
    @State private var selectedCourse: CloudCourse = .dataPartitioning
    
    var body: some View {
        VStack {
            List {
                ForEach(firestoreManager.cloudProjects, id: \.title) { cloudProject in
                    CardView(cloudProject: cloudProject)
                        .listRowBackground(cloudProject.theme.mainColor)
                }.onDelete{ (indexSet) in
                    firestoreManager.cloudProjects.remove(atOffsets: indexSet)
                }
            }.scrollContentBackground(.hidden)
        }.padding(.horizontal).navigationBarBackButtonHidden(true).toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Spacer()
                Button {
                } label: {
                    VStack{
                        Image(systemName:"house.fill").foregroundColor(.black)
                        Text("Courses").font(.footnote).foregroundColor(.black)
                    }
                }
                Spacer()
                Button {
                    self.addCoursesOpen = true
                } label: {
                    Image(systemName:"plus.app").foregroundColor(.black)

                }
                Spacer()
                Button {
                    self.isProfileOpen = true
                } label: {
                    VStack{
                        Image(systemName:"person.fill").foregroundColor(.black)
                        Text("Profile").font(.footnote).foregroundColor(.black)
                    }
                }
                Spacer()
            }
            
            ToolbarItemGroup(placement: .principal) {
                Text("Cloud Courses").font(.title).bold()
            }
        }.navigationDestination(isPresented: $isProfileOpen, destination: {
            ProfileView().environmentObject(firestoreManager).navigationBarBackButtonHidden(true)
        }).navigationDestination(isPresented: $addCoursesOpen, destination: {
            AddCoursesView().environmentObject(firestoreManager).navigationBarBackButtonHidden(true)
        })
    }
    
    func submitEvent() {
        firestoreManager.cloudProjects.insert(contentsOf: [selectedCourse.cloudProject], at: 0)
        firestoreManager.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ContentView().environmentObject(FirestoreManager())
        }
    }
}

enum CloudCourse: String, CaseIterable, Identifiable {
    case database, loadBalancer, caching, dataPartitioning, indexes, proxies
    var id: Self { self }
}

extension CloudCourse {
    var cloudProject: CloudProject {
        switch self {
        case .database: return CloudProject(title: "Databases",
                         progress: 0,
                                            slides: 5,
                       theme: .seafoam)
        case .loadBalancer: return CloudProject(title: "Load Balancers",
                         progress: 0,
                                                slides: 5,
                       theme: .sky)
        case .caching: return CloudProject(title: "Caching",
                         progress: 0,
                                           slides: 5,
                       theme: .sky)
        case .dataPartitioning: return CloudProject(title: "Data Partitioning",
                                                    progress: 0,
                                                    slides: 5,
                                                    theme: .sky)
        case .indexes: return CloudProject(title: "Indexes",
                                           progress: 0,
                                           slides: 5,
                                         theme: .sky)
        case .proxies: return CloudProject(title: "Proxies",
                                           progress: 0,
                                           slides: 5,
                                           theme: .sky)
        }
    }
}

struct CloudProject: Codable, Hashable {
    var title: String
    var progress: Int
    var slides: Int
    var theme: Theme
}

extension CloudProject {
    static let sampleData: [CloudProject] =
    [
        CloudProject(title: "Database",
                     progress: 0,
                     slides: 5,
                   theme: .seafoam),
        CloudProject(title: "Load Balancer",
                     progress: 0,
                     slides: 5,
                   theme: .sky),
        CloudProject(title: "Caching",
                     progress: 0,
                     slides: 5,
                   theme: .sky)
    ]
}

enum Theme: String, Codable {
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
    case black

    var accentColor: Color {
        switch self {
        case .bubblegum, .buttercup, .lavender, .orange, .periwinkle, .poppy, .seafoam, .sky, .tan, .teal, .yellow: return .black
        case .indigo, .magenta, .navy, .oxblood, .purple, .black: return .white
        }
    }
    
    var mainColor: Color {
        Color(rawValue)
    }
}
