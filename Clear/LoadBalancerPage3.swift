//
//  LoadBalancerPage3.swift
//  Clear
//
//  Created by Nadella, Vineet on 9/30/23.
//

import SwiftUI

struct LoadBalancerPage3: View {
    @Binding var unlock: Bool
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
            Text("Load Balancers Knowledge Check").font(.title2).bold().frame(maxWidth: .infinity, alignment: .leading)
            Text("")
            Text(quizData.question).font(.headline).bold().frame(maxWidth: .infinity)
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(quizData.optionsList) { quizOption in
                    VStack {
                        if (self.isSelected == 1) {
                            OptionStatusImageView(imageName: "checkmark")
                        } else if (self.isSelected == -1) {
                            OptionStatusImageView(imageName: "xmark")
                        } else {
                            OptionView(quizOption: quizOption)
                        }
                    }.frame(width: 150, height: 150)
                        .background(setBackgroundColor())
                        .background(setBackgroundColor())
                        .onTapGesture {
                            verifyAnswer(selectedOption: quizOption)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                self.isSelected = 0
                            }
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
        }
    }
    
    
    func verifyAnswer(selectedOption: QuizOption) {
        if (selectedOption.optionId == "B") {
            self.isSelected = 1
            self.unlock = true
        } else {
            self.isSelected = -1
        }
    }
    
    func setBackgroundColor() -> Color {
        if (self.isSelected == 1) {
            return Color.green
        } else if (self.isSelected == -1) {
            return Color.red
        } else {
            return Color.white
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

struct OptionStatusImageView: View {
    var imageName: String
    var body: some View {
        Image(systemName: imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding(EdgeInsets(top: 40, leading: 40, bottom: 40, trailing: 40))
            .foregroundColor(Color.white)
    }
}
    
struct LoadBalancerPage3_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LoadBalancerPage3(unlock: Binding.constant(false))
        }.padding()
    }
}
