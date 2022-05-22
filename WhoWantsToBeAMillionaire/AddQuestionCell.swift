//
//  AddQuestionCell.swift
//  WhoWantsToBeAMillionaire
//
//  Created by Максим Лосев on 20.05.2022.
//

import UIKit

class AddQuestionCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answersLabel: UILabel!
    @IBOutlet weak var answerATextField: UITextField!
    @IBOutlet weak var answerBTextField: UITextField!
    @IBOutlet weak var answerCTextField: UITextField!
    @IBOutlet weak var answerDTextField: UITextField!
    
    var correctAnswerSelected: Int?
    
    //MARK: Functions
    func configure() {
        guard let normalIcon = UIImage(systemName: "checkmark.circle"),
        let selectedIcon = UIImage(systemName: "checkmark.circle.fill") else { return }
        answerATextField.rightViewMode = .always
        answerATextField.rightView = createButton(normalIcon: normalIcon, selectedIcon: selectedIcon, tag: 0)
        answerBTextField.rightViewMode = .always
        answerBTextField.rightView = createButton(normalIcon: normalIcon, selectedIcon: selectedIcon, tag: 1)
        answerCTextField.rightViewMode = .always
        answerCTextField.rightView = createButton(normalIcon: normalIcon, selectedIcon: selectedIcon, tag: 2)
        answerDTextField.rightViewMode = .always
        answerDTextField.rightView = createButton(normalIcon: normalIcon, selectedIcon: selectedIcon, tag: 3)
    }
    
    func oneCorrectAnswerAllowedCheck() {
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func createButton(normalIcon: UIImage, selectedIcon: UIImage, tag: Int) -> UIButton {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: ((self.frame.height) * 0.70), height: ((self.frame.height) * 0.70)))
        btn.addTarget(self, action: #selector(correctAnswerSelected(_:)), for: .touchUpInside)
        btn.setImage(normalIcon, for: .normal)
        btn.setImage(selectedIcon, for: .selected)
        btn.tintColor = .darkGray
        btn.tag = tag
        return btn
    }
    
    @objc func correctAnswerSelected(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
        } else {
            sender.isSelected = true
            correctAnswerSelected = sender.tag
        }
    }
    
    func createQuestion() -> Question {
        var builder = Question()
        builder.question = questionLabel.text ?? ""
        let answers = [answerATextField.text ?? "", answerBTextField.text ?? "", answerCTextField.text ?? "", answerDTextField.text ?? ""]
        builder.answers = answers
        guard let correctAnswerSelected = correctAnswerSelected else { return Question()}
        builder.correctAnswer = answers[correctAnswerSelected]
        return builder.build()
    }

}
