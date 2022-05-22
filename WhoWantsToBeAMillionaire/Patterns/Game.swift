//
//  Game.swift
//  WhoWantsToBeAMillionaire
//
//  Created by Максим Лосев on 13.05.2022.
//

import Foundation

struct Result: Codable {
    let name: Date
    let answered: Double
    let isUsedFriendCall: Bool
    let isUsedAuditoryHelp: Bool
    let isUsed50to50Hint: Bool
}

class Game {
    
    //MARK: Constants
    static let shared = Game()
    private let resultsCaretaker = ResultsCaretaker()
    private(set) var results: [Result] = [] {
        didSet {
            resultsCaretaker.save(results: results)
        }
    }
    
    private let questionsCaretaker = QuestionsCaretaker()
    var questions: [Question] = [] {
        didSet {
            questionsCaretaker.save(questions: questions)
        }
    }
    
    //MARK: Properties
    var gameSession: GameSession?
    var difficalty: Difficulty = .easy
    
    //MARK: Initialization
    private init() {
        self.results = self.resultsCaretaker.retrieveRecords()
        self.questions = self.questionsCaretaker.retrieveQuestions()
    }
    
    //MARK: Functions
    func addResult() {
        guard let answeredQuestions = gameSession?.correctAnweredQuestions,
              let questionsQuantity = gameSession?.questionsQuantity,
              let date = gameSession?.createSessionDate,
              let isUsedFriendCall = gameSession?.isUsedFriendCall,
              let isUsedAuditoryHelp = gameSession?.isUsedAuditoryHelp,
              let isUsed50to50Hint = gameSession?.isUsed50to50Hint else {
            return
        }
        let percent = Double(answeredQuestions.value) / Double(questionsQuantity)
        let result = Result(name: date, answered: percent, isUsedFriendCall: isUsedFriendCall, isUsedAuditoryHelp: isUsedAuditoryHelp, isUsed50to50Hint: isUsed50to50Hint)
        results.append(result)
        gameSession = nil
    }
    
    func resetResults() {
        results = []
    }
    
}
