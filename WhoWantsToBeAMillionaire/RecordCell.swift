//
//  RecordCell.swift
//  WhoWantsToBeAMillionaire
//
//  Created by Максим Лосев on 13.05.2022.
//

import UIKit

class RecordCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var recordNameLabel: UILabel!
    @IBOutlet weak var recordValueLabel: UILabel!
    @IBOutlet weak var hint50to50Icon: UIImageView!
    @IBOutlet weak var callFriendIcon: UIImageView!
    @IBOutlet weak var auditoryHelpIcon: UIImageView!
    
    //MARK: Private properties
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy HH:mm:ss"
        return dateFormatter
    }()
    
    private let numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        return numberFormatter
    }()
    
    //MARK: Functions
    func configure(result: Result) {
        recordNameLabel.text = dateFormatter.string(from:result.name)
        recordValueLabel.text = numberFormatter.string(from: result.answered as NSNumber)
        if result.isUsed50to50Hint == true {
            hint50to50Icon.image = hint50to50Icon.image?.withRenderingMode(.alwaysTemplate)
            hint50to50Icon.tintColor = UIColor.white
        }
        if result.isUsedFriendCall == true {
            callFriendIcon.image = callFriendIcon.image?.withRenderingMode(.alwaysTemplate)
            callFriendIcon.tintColor = UIColor.white
        }
        if result.isUsedAuditoryHelp == true {
            auditoryHelpIcon.image = auditoryHelpIcon.image?.withRenderingMode(.alwaysTemplate)
            auditoryHelpIcon.tintColor = UIColor.white
        }
    }
    
    override func prepareForReuse() {
        recordNameLabel.text = nil
        recordValueLabel.text = nil
    }

}
