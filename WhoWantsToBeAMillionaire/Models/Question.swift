//
//  Question.swift
//  WhoWantsToBeAMillionaire
//
//  Created by Максим Лосев on 13.05.2022.
//

import Foundation

struct Question: Equatable, Codable {

    //MARK: Properties
    var question: String
    var answers: [String]
    var correctAnswer: String

    //MARK: Initializations
    init(question: String, answers: [String], correctAnswer: String) {
        self.question = question
        self.answers = answers
        self.correctAnswer = correctAnswer
    }
    
    init() {
        question = ""
        correctAnswer = ""
        answers = []
    }
    
    //MARK: Functions
    func checkAnswer(answer: String) -> Bool {
        return answer == self.correctAnswer
    }
    
    func useFriendCall() -> [Int:String] {
        let randomIndex = Int.random(in: 0..<4)
        var hint = [Int:String]()
        hint[randomIndex] = answers[randomIndex]
        return hint
    }
    
    func useAuditoryHelp() -> [Double] {
        var voteResults = [Double]()
        var totalVotes = 100.0
        for _ in 0...2 {
            let randomDouble = Double.random(in: 0.0...totalVotes)
            let roudedVoteResult = roundToCustomFormat(value: randomDouble, roundTo: 10)
            totalVotes = totalVotes - roudedVoteResult
            voteResults.append(roudedVoteResult)
        }
        voteResults.append(roundToCustomFormat(value: totalVotes, roundTo: 10))
        return voteResults
    }
    
    mutating func use50to50Hint() -> [String] {
        var hintResultSet = Set<Int>()
        var hintResults:[Int] = []
        repeat {
            hintResultSet = getSetAttempt()
            hintResults = Array(hintResultSet)
        } while answers[hintResults[0]] == correctAnswer || answers[hintResults[1]] == correctAnswer
        answers[hintResults[0]] = ""
        answers[hintResults[1]] = ""
        return answers
    }
    
    // MARK: Private functions
    private func roundToCustomFormat(value: Double, roundTo: Double) -> Double {
        return Double(round(value * roundTo)) / roundTo
    }
    
    private func getSetAttempt() -> Set<Int> {
        var hintResultSet = Set<Int>()
        while hintResultSet.count < 2 {
            let randomIndex = Int.random(in: 0..<4)
            hintResultSet.insert(randomIndex)
        }
        return hintResultSet
    }
    
    //MARK: Builder functions
    func build() -> Question {
        return Question(question: question, answers: answers, correctAnswer: correctAnswer)
    }
    
    mutating func setQuestion(_ question: String) {
        self.question = question
    }
    
    mutating func setCorrectAnswer(_ correctAnswer: String) {
        self.correctAnswer = correctAnswer
    }
    
    mutating func setAnswers(_ answers: [String]) {
        self.answers = answers
    }
    
}
