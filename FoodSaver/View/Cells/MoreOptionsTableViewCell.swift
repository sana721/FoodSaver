//
//  MoreOptionsTableViewCell.swift
//  FoodSaver
//
//  Created on 03/11/22.
//

import UIKit

class MoreOptionsTableViewCell: UITableViewCell {

    @IBOutlet fileprivate weak var titleLabel: UILabel!
    
    var title = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
