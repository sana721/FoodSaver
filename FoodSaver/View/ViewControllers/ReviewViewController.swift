//
//  ReviewViewController.swift
//  FoodSaver
//
//  Created on 10/11/22.
//

import UIKit
import FloatRatingView

class ReviewViewController: UIViewController, FloatRatingViewDelegate {

    @IBOutlet weak var commentsTextView: UITextView!
    @IBOutlet weak var ratingView: FloatRatingView!
    
    var food: Food? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ratingView.emptyImage = UIImage(named: "star_empty")
        ratingView.fullImage = UIImage(named: "star_full")
        ratingView.delegate = self
        ratingView.minRating = 0
        ratingView.maxRating = 5
    }
    
    @IBAction func onTapSave(_ sender: UIBarButtonItem) {
        if commentsTextView.text.isEmpty {
            showInfoAlert(title: NSLocalizedString("Review", comment: "Review"), message: NSLocalizedString("Please provide the comments.", comment: "Please provide the comments."), completion: nil)
            return
        }
        
        guard let review = DBManager.manager.newEntity(entity: .Review) as? Review,
            let f = food else {
                return
        }
        review.rating = ratingView.rating
        review.comment = commentsTextView.text
        f.addToReviews(review)
        review.user = AppManager.manager.loginAccount?.user
        DBManager.manager.saveContext()
        self.navigationController?.popViewController(animated: true)
    }
}
