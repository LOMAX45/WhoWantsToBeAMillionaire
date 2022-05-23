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
