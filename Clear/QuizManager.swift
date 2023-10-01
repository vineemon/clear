//
//  QuizManager.swift
//  Clear
//
//  Created by Nadella, Vineet on 9/30/23.
//

import Foundation
import SwiftUI

class QuizManager : ObservableObject {
    
    static var currentIndex = 0
    
    static func createGameModel(quizData: QuizData) -> Quiz {
        return Quiz(quizModel: quizData)
    }
    
    @Published var model = QuizManager.createGameModel(i: QuizManager.currentIndex)
}
