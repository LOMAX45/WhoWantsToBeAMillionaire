//
//  GameSession.swift
//  WhoWantsToBeAMillionaire
//
//  Created by Максим Лосев on 13.05.2022.
//

import Foundation

class GameSession {
    
    let createSessionDate = Date()
    let questionsQuantity: Int
    var correctAnweredQuestions = 0
    
    init(quetionsQuantity: Int){
        self.questionsQuantity = quetionsQuantity
    }

}

extension GameSession: GameControllerdelegate {
    func didEndGame(withResult result: Int) {
        self.correctAnweredQuestions = result
    }
}

