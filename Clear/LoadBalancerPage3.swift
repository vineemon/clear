//
//  LoadBalancerPage3.swift
//  Clear
//
//  Created by Nadella, Vineet on 9/30/23.
//

import SwiftUI

struct LoadBalancerPage3: View {
    @State var cloudProject: CloudProject
    @State var isSelected: Int = 0
    var columns: [GridItem] = Array(repeating: GridItem(.fixed(170), spacing: 0, alignment: .bottom), count: 2)
    var quizData: QuizModel {
        QuizModel(question: "Which is NOT a benefit of a load balancer?",
                  answer: "B",
                  optionsList: [QuizOption(id: 11, optionId: "A", option: "Users experience faster, uninterrupted service.", theme: .black),
                                QuizOption(id: 12,optionId: "B", option: "Services experience lower data access latency.", theme: .black),
                                QuizOption(id: 13,optionId: "C", option: "Several devices perform the work vs. a single device.", theme: .black),
                                QuizOption(id: 14,optionId: "D", option: "Services experience higher availability and throughput.", theme: .black)])
    }
    
    var body: some View {
        VStack() {
            Text("Load Balancers Knowledge Check").font(.custom("Avenir", size: 20)).bold().frame(maxWidth: .infinity, alignment: .leading)
            Text("")
            Text(quizData.question).font(.headline).bold().frame(maxWidth: .infinity)
            Spacer()
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(quizData.optionsList) { quizOption in
                    VStack {
                        OptionView(quizOption: quizOption)
                    }.frame(width: 150, height: 150)
                        .background(Color.white)
                        .onTapGesture {
                            verifyAnswer(selectedOption: quizOption)
                        }
                }
            }
            Spacer()
            Button {
                self.isSelected = 0
            } label: {
                HStack {
                    if (self.isSelected == -1) {
                        Text("That's not quite right. Try again!").foregroundColor(.black)
                    } else if (self.isSelected == 1) {
                        Text("Correct! Load balancers really are useful! Next page...").foregroundColor(.black)
                        Image(systemName: "arrow.forward").foregroundColor(.black)
                    }
                    
                }
            }
            Spacer()
        }.toolbar {
            ToolbarItemGroup(placement: .principal) {
                Text("Load Balancer").font(.custom("Avenir", size: 30)).bold()
            }
        }
    }
    
    
    func verifyAnswer(selectedOption: QuizOption) {
        if (selectedOption.optionId == "B") {
            self.isSelected = 1
            self.cloudProject.slide = 5
        } else {
            self.isSelected = -1
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.isSelected = 0
            }
        }
    }

}

struct OptionView: View {
    var quizOption: QuizOption
    var body: some View {
        VStack {
            Text(quizOption.optionId)
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .frame(width: 50, height: 50)
                .background(quizOption.theme.mainColor.opacity(0.8))
                .foregroundColor(.white)
                .cornerRadius(25)
            
            Text(quizOption.option)
                .multilineTextAlignment(.center)
                .frame(maxHeight: .infinity)
        }
    }
}
    
struct LoadBalancerPage3_Previews: PreviewProvider {
    @State static var testCloudProject = CloudProject(title: "Load Balancer",
                 progress: 0,
                 slide: 5,
               theme: .sky)
    static var previews: some View {
        NavigationStack {
            LoadBalancerPage3(cloudProject: testCloudProject)
        }.padding()
    }
}
