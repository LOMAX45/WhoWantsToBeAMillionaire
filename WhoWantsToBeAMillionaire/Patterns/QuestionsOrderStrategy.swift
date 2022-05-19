//
//  QuestionsOrderStrategy.swift
//  WhoWantsToBeAMillionaire
//
//  Created by Максим Лосев on 19.05.2022.
//

import Foundation

protocol QuestionsOrderStrategy {
    func createQuestionsOrder(from questions: [Question]) -> [Question]
}

final class ConsistentQuestionsOrderStrategy: QuestionsOrderStrategy {
    func createQuestionsOrder(from questions: [Question]) -> [Question] {
        return questions
    }
}

final class RandomQuestionsOrderStrategy: QuestionsOrderStrategy {
    func createQuestionsOrder(from questions: [Question]) -> [Question] {
        return questions.shuffled()
    }
}
