//
//  HintsActionsFacade.swift
//  WhoWantsToBeAMillionaire
//
//  Created by Максим Лосев on 23.05.2022.
//

import Foundation
import UIKit

enum Hint {
    case hint50to50Button, callFriendButton, auditoryHelpButton
}

class HintsActionsFacade {
    
    //MARK: Properties
    var hint: Hint?
    var currentQuestion: Question
    
    //MARK: Initializations
    init(hint: Hint, currentQuestion: Question) {
        self.hint = hint
        self.currentQuestion = currentQuestion
    }
    
    //MARK: Functions
    func callfriend() -> [Int: String] {
        guard let gameSession = Game.shared.gameSession else {
            return [:]
        }
        let advice = currentQuestion.useFriendCall()
        gameSession.isUsedFriendCall = true
        return advice
    }
    
    func useAuditoryHelp() -> [Double] {
        guard let gameSession = Game.shared.gameSession else {
            return []
        }
        let voteResults = currentQuestion.useAuditoryHelp()
        gameSession.isUsedAuditoryHelp = true
        return voteResults
    }
    
    func use50to50Hint() -> Question {
        guard let gameSession = Game.shared.gameSession else {
            return currentQuestion
        }
        let answers = currentQuestion.use50to50Hint()
        let question = Question(question: currentQuestion.question, answers: answers, correctAnswer: currentQuestion.correctAnswer)
        gameSession.isUsed50to50Hint = true
        return question
    }
}
