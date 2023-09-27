//
//  CardView.swift
//  Clear
//
//  Created by Vineet Nadella on 9/8/23.
//

import SwiftUI

struct CardView: View {
    let cloudProject: CloudProject
    @State var isLearningViewActive = false
    var body: some View {
        VStack(alignment: .leading) {
            Button() {
                self.isLearningViewActive = true
            } label: {
                HStack {
                    Text(cloudProject.title)
                        .font(.headline)
                        .accessibilityAddTraits(.isHeader)
                    Spacer()
                }
                Spacer()
                HStack {
                    Label(String(cloudProject.slides) + " Slides", systemImage: "chart.bar.fill")
                    Spacer()
                    ProgressView(value: Float(cloudProject.progress)/Float(cloudProject.slides)) { Text("\(Int(cloudProject.progress/cloudProject.slides*100))% completed") }.frame(width:100)
//                    Label("\(cloudProject.time)", systemImage: "clock")
//                        .padding(.trailing, 20)
                }
                .font(.caption)
            }
            .font(.caption).foregroundColor(.black)
        }.navigationDestination(isPresented: $isLearningViewActive, destination: {
            LearningView(cloudProject: cloudProject)
        }).padding()
            .foregroundColor(cloudProject.theme.accentColor)
}
}

//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView(nil)
//    }
//}
