//
//  ReviewTableViewCell.swift
//  FoodSaver
//
//  Created on 06/11/22.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    var review: Review? = nil {
        didSet {
            titleLabel.text = "\(review?.user?.firstname ?? "") \(review?.user?.lastname ?? "")"
            ratingLabel.text = "\(review?.rating ?? 0.0) / 5.0"
            commentsLabel.text = review?.comment
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
