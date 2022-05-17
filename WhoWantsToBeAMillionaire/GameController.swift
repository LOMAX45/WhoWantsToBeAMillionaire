//
//  GameController.swift
//  WhoWantsToBeAMillionaire
//
//  Created by Максим Лосев on 13.05.2022.
//

import UIKit

protocol GameControllerdelegate: AnyObject {
    func didEndGame(withResult result: Int)
}

class GameController: UIViewController {
    
    weak var delegate: GameControllerdelegate?

    var questions = allQuestions
    var questionCounter = 0
    var gameSession:GameSession?
    
    @IBOutlet weak var QuestionNumberLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerA: UIButton!
    @IBOutlet weak var answerB: UIButton!
    @IBOutlet weak var answerC: UIButton!
    @IBOutlet weak var answerD: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showQuestion(withQuestion: questions[questionCounter])
    }
    
    @IBAction func answerSelected(_ sender: UIButton) {
        if questions[questionCounter].checkAnswer(answer: sender.currentTitle ?? "") && questionCounter < questions.count - 1 {
            questionCounter += 1
            showQuestion(withQuestion: questions[questionCounter])
        } else {
            if questionCounter == questions.count - 1 {
                questionCounter += 1
            }
            self.delegate?.didEndGame(withResult: questionCounter)
            Game.shared.addResult()
            dismiss(animated: true)
        }
    }
    
    private func showQuestion(withQuestion question: Question ) {
        QuestionNumberLabel.text = "Вопрос №\(questionCounter + 1)"
        questionLabel.text = question.question
        answerA.setTitle(question.answers[0], for: .normal)
        answerB.setTitle(question.answers[1], for: .normal)
        answerC.setTitle(question.answers[2], for: .normal)
        answerD.setTitle(question.answers[3], for: .normal)
    }
    
}
