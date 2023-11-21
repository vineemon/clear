//
//  CardView.swift
//  Clear
//
//  Created by Vineet Nadella on 9/8/23.
//

import SwiftUI

struct CardView: View {
    @EnvironmentObject var firestoreManager: FirestoreManager
    @State var cloudProject: CloudProject
    @State var isLearningViewActive = false
    
    var learningViewsDict: [String: [Any]] = [
        "Databases": [DatabasePage1.self, DatabasePage2.self],
        "Load Balancers": [LoadBalancerPage1.self, LoadBalancerPage2.self, LoadBalancerPage3.self, EmptyView.self, EmptyView.self],
        "Caching": [CachingPage1.self, CachingPage2.self, EmptyView.self],
        "Data Partitioning": [EmptyView.self, EmptyView.self, EmptyView.self],
        "Indexes": [EmptyView.self, EmptyView.self, EmptyView.self],
        "Proxies": [EmptyView.self, EmptyView.self, EmptyView.self]
    ]
    
    var body: some View {
        let learningViews = learningViewsDict[cloudProject.title]!
        VStack(alignment: .leading) {
            Button() {
                self.isLearningViewActive = true
            } label: {
                HStack {
                    Text(cloudProject.title)
                        .font(.custom("Avenir", size: 15))
                        .accessibilityAddTraits(.isHeader)
                    Spacer()
                }
                Spacer()
                HStack {
                    // change slides to be count
                    Label(String(learningViews.count) + " Slides", systemImage: "chart.bar.fill")
                    Spacer()
                    ProgressView(value: Float(cloudProject.progress)/Float(learningViews.count)) { Text("\(Int(cloudProject.progress/learningViews.count*100))% completed") }.frame(width:100)
                }
                .font(.custom("Avenir", size: 10))
            }
            .font(.caption).foregroundColor(.black)
        }.navigationDestination(isPresented: $isLearningViewActive, destination: {
            LearningView(cloudProject: cloudProject, learningViews: learningViews).environmentObject(firestoreManager)
        }).padding()
            .foregroundColor(cloudProject.theme.accentColor)
}
}

struct CardView_Previews: PreviewProvider {
    @State static var cloudProjectTest: CloudProject = CloudProject(
        title: "Caching",
        progress: 0,
        slide: 5,
        theme: .seafoam)
    static var previews: some View {
        NavigationStack {
            CardView(cloudProject: cloudProjectTest)
        }
    }
}
