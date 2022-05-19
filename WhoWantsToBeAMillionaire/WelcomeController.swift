//
//  WelcomeController.swift
//  WhoWantsToBeAMillionaire
//
//  Created by Максим Лосев on 13.05.2022.
//

import UIKit

class WelcomeController: UIViewController {
    
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var showRecordsButton: UIButton!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "StartGameSegue":
            guard let destination = segue.destination as? GameController else { return }
            destination.gameSession = GameSession(quetionsQuantity: allQuestions.count)
            destination.delegate = destination.gameSession
            Game.shared.gameSession = destination.gameSession
        default:
            break
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
