//
//  GameController.swift
//  WhoWantsToBeAMillionaire
//
//  Created by Максим Лосев on 13.05.2022.
//

import UIKit

protocol GameControllerdelegate: AnyObject {
    func didEndGame(withResult result: Int)
    
    func didUseHint(isUsedFriendCall: Bool, isUsedAuditoryHelp: Bool, isUsed50to50Hint: Bool)
}

class GameController: UIViewController {
    
    weak var delegate: GameControllerdelegate?
    
    var questions = allQuestions
    var questionCounter = 0
    var gameSession:GameSession?
    var isResetBackgroundButtonNeeded: UIButton?
    var isRemoveVoteResultsLabelNeeded: Bool?
    
    @IBOutlet weak var hintsStack: UIStackView!
    @IBOutlet weak var answersStack: UIStackView!
    @IBOutlet weak var hint50to50Button: UIButton!
    @IBOutlet weak var callFriendButton: UIButton!
    @IBOutlet weak var auditoryHelpButton: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var QuestionNumberLabel: UILabel!
    @IBOutlet weak var answerA: UIButton!
    @IBOutlet weak var answerB: UIButton!
    @IBOutlet weak var answerC: UIButton!
    @IBOutlet weak var answerD: UIButton!
    @IBOutlet weak var voteResultslabel: UILabel!
    
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
    
    @IBAction func useHint(_ sender: UIButton) {
        switch sender {
        case hint50to50Button:
            questions[questionCounter].use50to50Hint()
            showQuestion(withQuestion: questions[questionCounter])
            self.delegate?.didUseHint(isUsedFriendCall: false, isUsedAuditoryHelp: false, isUsed50to50Hint: true)
            hint50to50Button.isEnabled = false
        case callFriendButton:
            guard let friendAnswer = questions[questionCounter].useFriendCall().first?.key else { return }
            switch friendAnswer {
            case 0:
                highlightButton(button: answerA)
            case 1:
                highlightButton(button: answerB)
            case 2:
                highlightButton(button: answerC)
            case 3:
                highlightButton(button: answerD)
            default:
                break
            }
            self.delegate?.didUseHint(isUsedFriendCall: true, isUsedAuditoryHelp: false, isUsed50to50Hint: false)
            callFriendButton.isEnabled = false
        case auditoryHelpButton:
            let voteResults = questions[questionCounter].useAuditoryHelp()
            addVoteResults(results: voteResults)
            self.delegate?.didUseHint(isUsedFriendCall: false, isUsedAuditoryHelp: true, isUsed50to50Hint: false)
            auditoryHelpButton.isEnabled = false
        default: break
        }
    }
    
// MARK: Private functions
    private func highlightButton(button: UIButton) {
        button.backgroundColor = UIColor.orange
        isResetBackgroundButtonNeeded = button
    }
    
    private func resetBackgroundButtons(button: UIButton) {
        button.backgroundColor = .none
        isResetBackgroundButtonNeeded = nil
    }

    
    private func showQuestion(withQuestion question: Question) {
        if isResetBackgroundButtonNeeded != nil {
            resetBackgroundButtons(button: isResetBackgroundButtonNeeded!)
        }
        if isRemoveVoteResultsLabelNeeded == true {
            voteResultslabel.text = ""
            isRemoveVoteResultsLabelNeeded = nil
        }
        QuestionNumberLabel.text = "Вопрос №\(questionCounter + 1)"
        questionLabel.text = question.question
        answerA.setTitle(question.answers[0], for: .normal)
        answerB.setTitle(question.answers[1], for: .normal)
        answerC.setTitle(question.answers[2], for: .normal)
        answerD.setTitle(question.answers[3], for: .normal)
    }
    
    private func addVoteResults (results: [Double]) {
        isRemoveVoteResultsLabelNeeded = true
        voteResultslabel.text = "A: \(results[0])%; B: \(results[1])%; C: \(results[2])%; D: \(results[3])%"
    }
    
}
