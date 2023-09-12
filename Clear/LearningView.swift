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
    @State var isPopoverPresented = false
    @State var isEditTimelinesActive = false
    @State var isCreateTimelinesActive = false
    @State var isSettingsActive = false
    @State var isLoggedOut = false
    
    
    let conceptToPages: [String: [some View]] = [
            "Database" : [DatabasePage1(), DatabasePage1(), DatabasePage1()],
            "Load Balancer" :[DatabasePage1(), DatabasePage1(), DatabasePage1()],
            "Caching" :[DatabasePage1(), DatabasePage1(), DatabasePage1()]
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
            
            // learning here, dependent on cloudproject
            TabView {
                ForEach(0..<conceptToPages[cloudProject.title]!.count, id:\.self) {i in
                    conceptToPages[cloudProject.title]![i]
                }
            }.tabViewStyle(.page)
        }.padding()
    }
    
//    func getView(String title, Int i) -> some View {
//
//    }
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
