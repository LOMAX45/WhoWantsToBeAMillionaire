//
//  AddQuestionController.swift
//  WhoWantsToBeAMillionaire
//
//  Created by Максим Лосев on 20.05.2022.
//

import UIKit

class AddQuestionController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    
    var cellsCounter = 1
    var questions = [Question]()
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        //MARK: Hide keyboard regognizer
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tableView.addGestureRecognizer(hideKeyboardGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) { super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) { super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func saveQuestions(_ sender: Any) {
        for row  in 0 ..< self.tableView.numberOfRows(inSection: 0) {
            let indexPath = IndexPath(row: row, section: 0)
            let cell = self.tableView.cellForRow(at: indexPath) as! AddQuestionCell
            if !checkFilling(cell: cell) {
                let alert = UIAlertController(title: "ОШИБКА",
                                              message: "Не выбран правильный ответ",
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                self.present(alert, animated: true)
            } else {
                questions.append(cell.createQuestion())
                for question in questions {
                    Game.shared.questions.append(question)
                }
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func addCell(_ sender: Any) {
        cellsCounter += 1
        tableView.reloadData()
    }
    
    func checkFilling(cell: AddQuestionCell) -> Bool {
        return cell.correctAnswerSelected != nil
    }
    
    //MARK: Functions for work with keyboard
    @objc func keyboardWasShown(notification: Notification) {
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        // Добавляем отступ внизу UIScrollView, равный размеру клавиатуры
        self.tableView.contentInset = contentInsets
        tableView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillBeHidden(notification: Notification) {
        // Устанавливаем отступ внизу UIScrollView, равный 0
        let contentInsets = UIEdgeInsets.zero
        tableView.contentInset = contentInsets
    }
    
    @objc func hideKeyboard() { self.tableView.endEditing(true)
        
    }
    
}

extension AddQuestionController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellsCounter
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddQuestionCell", for: indexPath) as! AddQuestionCell
        cell.configure()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
