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
    
    @State var loadBalancerUnlock = false
    
    init(cloudProject: CloudProject) {
        self.cloudProject = cloudProject
        UIPageControl.appearance().currentPageIndicatorTintColor = .systemBlue
        UIPageControl.appearance().pageIndicatorTintColor = .gray
        UIPageControl.appearance().tintColor = .gray
    }
    
    // start with only 3 slides for Load Balancers
    // open up the next 3 slides after unlocked
    
    var body: some View {
        VStack(alignment: .leading){
            // learning here, dependent on cloudproject
            TabView {
                ForEach(0..<cloudProject.slides, id:\.self) {i in
                    if "Databases" == cloudProject.title {
                        if i == 0 {
                            DatabasePage1()
                        } else if i == 1 {
                            DatabasePage1()
                        } else {
                            DatabasePage1()
                        }
                    }
                    else if "Load Balancers" == cloudProject.title {
                        if i == 0 {
                            LoadBalancerPage1()
                        } else if i == 1 {
                            LoadBalancerPage2()
                        } else if i == 2 {
                            LoadBalancerPage3(unlock: $loadBalancerUnlock)
                        } else if (loadBalancerUnlock) {
                            LoadBalancerPage2()
                        }
                    }
                    else {
                        LoadBalancerPage1()
                    }
                }
            }.tabViewStyle(.page)
        }.padding().navigationTitle(Text(cloudProject.title)).navigationBarTitleDisplayMode(.large).navigationDestination(isPresented: $isSettingsActive, destination: {
            SettingsView()
        }).navigationDestination(isPresented: $isLoggedOut, destination: {
            LoginView().environmentObject(FirestoreManager()).navigationBarBackButtonHidden(true).navigationBarTitleDisplayMode(.inline)
        })
    }
}

struct LearningView_Previews: PreviewProvider {
    static var previews: some View {
        LearningView(cloudProject: CloudProject(
            title: "Databases",
            progress: 0,
            slides: 5,
            theme: .seafoam))
    }
}

// Create map of title to paged content like Database: Page 1 Databases, Page 2 Visuals, Page 3 Exercises

//
