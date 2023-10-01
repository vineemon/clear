//
//  QuizModel.swift
//  Clear
//
//  Created by Nadella, Vineet on 9/30/23.
//

import Foundation
import SwiftUI

struct Quiz {
    var currentQuestionIndex: Int
    var quizModel: QuizModel
    var quizCompleted: Bool = false
    var quizWinningStatus: Bool = false
}

struct QuizModel {
    var question: String
    var answer: String
    var optionsList: [QuizOption]
}

struct QuizOption : Identifiable {
    var id: Int
    var optionId: String
    var option: String
    var theme: Theme
    var isSelected : Bool = false
    var isMatched : Bool = false
}
