//
//  LearningView.swift
//  Clear
//
//  Created by Vineet Nadella on 9/12/23.
//

import SwiftUI

struct LearningView: View {
    let cloudProject: CloudProject
    @State var isLearningViewActive = false
    @State var isSettingsActive = false
    @State var isLoggedOut = false
    
    
    let conceptToPages = [
        "Database" : 3,
        "Load Balancer" :3,
        "Caching" :3
    ]
    
    init(cloudProject: CloudProject) {
        self.cloudProject = cloudProject
        UIPageControl.appearance().currentPageIndicatorTintColor = .systemBlue
        UIPageControl.appearance().pageIndicatorTintColor = .gray
        UIPageControl.appearance().tintColor = .gray
    }
    
    var body: some View {
        VStack(alignment: .leading){
            HStack() {
                Spacer()
                Text(cloudProject.title).font(.system(size: 24)).bold()
                Spacer()
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
            
            // learning here, dependent on cloudproject
            TabView {
                ForEach(0..<conceptToPages[cloudProject.title]!, id:\.self) {i in
                    if "Database" == cloudProject.title {
                        if i == 0 {
                            DatabasePage1()
                        } else if i == 1 {
                            DatabasePage1()
                        } else {
                            DatabasePage1()
                        }
                    }
                    else if "Load Balancer" == cloudProject.title {
                        if i == 0 {
                            LoadBalancerPage1()
                        } else if i == 1 {
                            DatabasePage1()
                        } else {
                            DatabasePage1()
                        }
                    }
                    else {
                        LoadBalancerPage1()
                    }
                }
            }.tabViewStyle(.page)
        }.padding()
    }
}

struct LearningView_Previews: PreviewProvider {
    static var previews: some View {
        LearningView(cloudProject: CloudProject(title: "Database",
                       time: 400,
                         difficulty: "Medium",
                       theme: .seafoam))
    }
}

// Create map of title to paged content like Database: Page 1 Databases, Page 2 Visuals, Page 3 Exercises

//
