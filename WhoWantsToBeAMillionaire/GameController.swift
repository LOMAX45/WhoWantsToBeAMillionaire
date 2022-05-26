//
//  GameController.swift
//  WhoWantsToBeAMillionaire
//
//  Created by Максим Лосев on 13.05.2022.
//

import UIKit

protocol GameControllerDelegate: AnyObject {
    func saveResult(withResult result: Int)
}

class GameController: UIViewController {
    
    // MARK: Properties
    weak var delegate: GameControllerDelegate?
    
    var questions = Game.shared.questions
    var questionCounter = 0
    var gameSession:GameSession?
    var isResetBackgroundButtonNeeded: UIButton?
    var isRemoveVoteResultsLabelNeeded: Bool?
    var difficalty: Difficulty?
    var questionOrderStrategy: QuestionsOrderStrategy?
    
    @IBOutlet weak var hintsStack: UIStackView!
    @IBOutlet weak var answersStack: UIStackView!
    @IBOutlet weak var hint50to50Button: UIButton!
    @IBOutlet weak var callFriendButton: UIButton!
    @IBOutlet weak var auditoryHelpButton: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var answerA: UIButton!
    @IBOutlet weak var answerB: UIButton!
    @IBOutlet weak var answerC: UIButton!
    @IBOutlet weak var answerD: UIButton!
    @IBOutlet weak var voteResultslabel: UILabel!
    
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        questions = getQuestionsList(from: questions)
        showQuestion(withQuestion: questions[questionCounter])
        
        gameSession?.correctAnweredQuestions.addObserver(self, options: [.new, .initial], closure: { [weak self] (correctAnweredQuestions, _) in
            guard let questionsCount = self?.questions.count else { return }
            self?.questionNumberLabel.text = "Вопрос №\(correctAnweredQuestions + 1) из \(questionsCount) пройдено (\(Int(Double(correctAnweredQuestions) / Double(questionsCount) * 100)))%"
        })
    }
    
    //MARK: Functions
    @IBAction func answerSelected(_ sender: UIButton) {
        if questions[questionCounter].checkAnswer(answer: sender.currentTitle ?? "") && questionCounter < questions.count - 1 {
            questionCounter += 1
            self.delegate?.saveResult(withResult: questionCounter)
            showQuestion(withQuestion: questions[questionCounter])
        } else {
            if questionCounter == questions.count - 1 {
                questionCounter += 1
            }
            self.delegate?.saveResult(withResult: questionCounter)
            Game.shared.addResult()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func useHint(_ sender: UIButton) {
        switch sender {
        case hint50to50Button:
            let hintsActionFacade = HintsActionsFacade(hint: Hint.hint50to50Button, currentQuestion: questions[questionCounter])
            let question = hintsActionFacade.use50to50Hint()
            sender.isEnabled = false
            showQuestion(withQuestion: question)
        case callFriendButton:
            let hintsActionFacade = HintsActionsFacade(hint: Hint.callFriendButton, currentQuestion: questions[questionCounter])
            sender.isEnabled = false
            guard let friendAnswer = hintsActionFacade.callfriend().first?.key else { return }
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
        case auditoryHelpButton:
            let hintsActionFacade = HintsActionsFacade(hint: Hint.auditoryHelpButton, currentQuestion: questions[questionCounter])
            sender.isEnabled = false
            let voteResults = hintsActionFacade.useAuditoryHelp()
            addVoteResults(results: voteResults)
        default:
            break
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
    
    private func getQuestionsList(from questions: [Question]) -> [Question] {
        if difficalty == .easy {
            questionOrderStrategy = ConsistentQuestionsOrderStrategy()
        } else {
            questionOrderStrategy = RandomQuestionsOrderStrategy()
        }
        guard let questionOrderStrategy = questionOrderStrategy else { return questions }
        return (questionOrderStrategy.createQuestionsOrder(from: questions))
    }
}
