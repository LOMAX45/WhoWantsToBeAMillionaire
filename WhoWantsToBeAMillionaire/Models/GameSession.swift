//
//  GameSession.swift
//  WhoWantsToBeAMillionaire
//
//  Created by Максим Лосев on 13.05.2022.
//

import Foundation

class GameSession {
    
    //MARK: Constants
    let createSessionDate = Date()
    let questionsQuantity: Int
    
    //MARK: Properties
    var correctAnweredQuestions = Observable<Int>(0)
    var isUsedFriendCall = false
    var isUsedAuditoryHelp = false
    var isUsed50to50Hint = false
    
    //MARK: Initializations
    init(quetionsQuantity: Int){
        self.questionsQuantity = quetionsQuantity
    }
    
}

extension GameSession: GameControllerdelegate {
    func saveResult(withResult result: Int) {
        self.correctAnweredQuestions.value = result
    }
    
    func didUseHint(isUsedFriendCall: Bool, isUsedAuditoryHelp: Bool, isUsed50to50Hint: Bool) {
        if isUsedFriendCall {
            self.isUsedFriendCall = isUsedFriendCall
        }
        if isUsedAuditoryHelp {
            self.isUsedAuditoryHelp = isUsedAuditoryHelp
        }
        if isUsed50to50Hint {
            self.isUsed50to50Hint = isUsed50to50Hint
        }
    }
}

