//
//  RecordCell.swift
//  WhoWantsToBeAMillionaire
//
//  Created by Максим Лосев on 13.05.2022.
//

import UIKit

class RecordCell: UITableViewCell {
    
    @IBOutlet weak var recordNameLabel: UILabel!
    @IBOutlet weak var recordValueLabel: UILabel!
    
    func configure(name: String, record: String) {
        recordNameLabel.text = name
        recordValueLabel.text = record
    }
    
    override func prepareForReuse() {
        recordNameLabel.text = nil
        recordValueLabel.text = nil
    }

}
