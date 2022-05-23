//
//  SettingsController.swift
//  WhoWantsToBeAMillionaire
//
//  Created by Максим Лосев on 19.05.2022.
//

import UIKit

class SettingsController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var difficultyControl: UISegmentedControl!
    @IBOutlet weak var saveAndExitButton: UIButton!
    
    //MARK: Private properties
    private var selectedDifficulty: Difficulty {
        switch self.difficultyControl.selectedSegmentIndex {
        case 0:
            return .easy
        case 1:
            return .hard
        default:
            return .easy
        }
    }

    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: Functions
    @IBAction func saveAndExitTapped(_ sender: Any) {
        Game.shared.difficalty = self.selectedDifficulty
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func removeQuestions(_ sender: Any) {
        Game.shared.questions = allQuestions
        self.navigationController?.dismiss(animated: true)
    }
    
}
