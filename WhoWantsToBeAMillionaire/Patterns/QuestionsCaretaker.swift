//
//  QuestionsCaretaker.swift
//  WhoWantsToBeAMillionaire
//
//  Created by Максим Лосев on 22.05.2022.
//

import Foundation

class QuestionsCaretaker {
    
    //MARK: Constants
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let key = "questions"
    
    //MARK: Functions
    func save(questions: [Question]) {
        do {
            let data = try self.encoder.encode(questions)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }
    
    func retrieveQuestions() -> [Question] {
        guard let data = UserDefaults.standard.data(forKey: key) else { return allQuestions }
        do {
            return try self.decoder.decode([Question].self, from: data)
        } catch {
            print(error)
            return allQuestions
        }
    }
    
}
