//
//  ResultsCaretaker.swift
//  WhoWantsToBeAMillionaire
//
//  Created by Максим Лосев on 16.05.2022.
//

import Foundation

class ResultsCaretaker {
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private let key = "records"
    
    func save(results: [Result]) {
        do {
            let data = try self.encoder.encode(results)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }
    
    func retrieveRecords() -> [Result] {
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        do {
            return try self.decoder.decode([Result].self, from: data)
        } catch {
            print(error)
            return[]
        }
    }
    
}
