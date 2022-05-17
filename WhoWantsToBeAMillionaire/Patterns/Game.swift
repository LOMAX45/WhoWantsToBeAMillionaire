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
}

class Game {
    
    static let shared = Game()
    
    private let resultsCaretaker = ResultsCaretaker()
    
    var gameSession: GameSession?
    private(set) var results: [Result] = [] {
        didSet {
            resultsCaretaker.save(results: results)
        }
    }
    
    private init() {
        self.results = self.resultsCaretaker.retrieveRecords()
    }
    
    func addResult() {
        guard let answeredQuestions = gameSession?.correctAnweredQuestions,
              let questionsQuantity = gameSession?.questionsQuantity,
              let date = gameSession?.createSessionDate else {
            return
        }
        let percent = Double(answeredQuestions) / Double(questionsQuantity)
        let result = Result(name: date, answered: percent)
        results.append(result)
        gameSession = nil
    }
    
    func resetResults() {
        results = []
    }
    
}
