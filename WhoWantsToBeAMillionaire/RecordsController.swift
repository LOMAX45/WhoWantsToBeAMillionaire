//
//  RecordsController.swift
//  WhoWantsToBeAMillionaire
//
//  Created by Максим Лосев on 13.05.2022.
//

import UIKit

class RecordsController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var clearResultsButton: UIButton!
    
    @IBAction func clearResultsHistory(_ sender: Any) {
        Game.shared.resetResults()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

    }

}

extension RecordsController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Game.shared.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recordCell", for: indexPath) as! RecordCell
        let result = Game.shared.results[indexPath.row]
        cell.configure(result: result)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
