//
//  LearningView.swift
//  Clear
//
//  Created by Vineet Nadella on 9/12/23.
//

import SwiftUI

struct LearningView: View {
    @EnvironmentObject var firestoreManager: FirestoreManager
    @State var cloudProject: CloudProject
    var learningViews: [Any]
    @State var isLearningViewActive = false
    @State var isSettingsActive = false
    @State var isLoggedOut = false
    
    @State var loadBalancerUnlock = false
    
    init(cloudProject: CloudProject, learningViews: [Any]) {
        self.cloudProject = cloudProject
        self.learningViews = learningViews
        UIPageControl.appearance().currentPageIndicatorTintColor = .systemBlue
        UIPageControl.appearance().pageIndicatorTintColor = .gray
        UIPageControl.appearance().tintColor = .gray
    }
    
    var body: some View {
        VStack(alignment: .leading){
            // learning here, dependent on cloudproject
            TabView {
                ForEach(0..<learningViews.count, id: \.self) {i in
                    // start with only 3 slides for Load Balancers
                    // open up the next 3 slides after unlocked
                    if i < cloudProject.slide {
                        switch learningViews[i].self {
                        case is DatabasePage1.Type: DatabasePage1()
                        case is DatabasePage2.Type: DatabasePage2()
                        case is LoadBalancerPage1.Type: LoadBalancerPage1()
                        case is LoadBalancerPage2.Type: LoadBalancerPage2()
                        case is LoadBalancerPage3.Type: LoadBalancerPage3(cloudProject: cloudProject)
                        case is CachingPage1.Type: CachingPage1().environmentObject(firestoreManager)
                        case is CachingPage2.Type: CachingPage2()
                        default: EmptyView()
                        }
                    }
                }
            }.tabViewStyle(.page)
        }.padding().navigationDestination(isPresented: $isSettingsActive, destination: {
            SettingsView()
        }).navigationDestination(isPresented: $isLoggedOut, destination: {
            LoginView().environmentObject(firestoreManager).navigationBarBackButtonHidden(true).navigationBarTitleDisplayMode(.inline)
        })
    }
}


struct LearningView_Previews: PreviewProvider {
    @State static var cloudProjectTest: CloudProject = CloudProject(
        title: "Load Balancers",
        progress: 0,
        slide: 5,
        theme: .seafoam)
    static var previews: some View {
        NavigationStack {
            LearningView(cloudProject: cloudProjectTest, learningViews: [LoadBalancerPage1.self, LoadBalancerPage2.self])
        }
    }
}
