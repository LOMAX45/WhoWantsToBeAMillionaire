//
//  WelcomeController.swift
//  WhoWantsToBeAMillionaire
//
//  Created by Максим Лосев on 13.05.2022.
//

import UIKit

class WelcomeController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var showRecordsButton: UIButton!
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: Functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "StartGameSegue":
            guard let destination = segue.destination as? GameController else { return }
            destination.gameSession = GameSession(quetionsQuantity: Game.shared.questions.count)
            destination.delegate = destination.gameSession
            destination.difficalty = Game.shared.difficalty
            Game.shared.gameSession = destination.gameSession
        default:
            break
        }
    }
}
