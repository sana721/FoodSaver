//
//  FoodTableViewCell.swift
//  FoodSaver
//
//  Created on 05/11/22.
//

import UIKit

protocol FoodTableViewCellDelegate {
    func didSelectedFavorite(cell: FoodTableViewCell, favorite: Bool, food: Food)
    func didLikeFood(cell: FoodTableViewCell, food: Food)
    func didUnlikeFood(cell: FoodTableViewCell, food: Food)
}

protocol FoodTableViewCellDataSource {
    func isFoodFavorite(food: Food) -> Bool
}

class FoodTableViewCell: UITableViewCell {

    var food: Food? {
        didSet {
            title.text = food?.title
            descriptionLabel.text = food?.desc
            availabiletyLable.text = "\((food?.quantity ?? 0) - (food?.donatedQuantity ?? 0)) / \(food?.quantity ?? 0)"
            likecountLabel.text = "\(food?.likes ?? 0)"
            unlikeCountLabel.text = "\(food?.dislike ?? 0)"
            if let data = food?.image {
                photoImageView.image = UIImage(data: data)
            } else {
                photoImageView.image = nil
            }
            if let f = food {
                favoriteButton.isSelected = dataSource?.isFoodFavorite(food: f) ?? false
            } else {
                favoriteButton.isSelected = false
            }
            typeImageView.tintColor = (food?.isVeg ?? true) ? UIColor(named: "veg") : UIColor(named: "nonveg")
            expiredLabel.isHidden = !(food?.isExpired() ?? false)
        }
    }
    
    var delegate: FoodTableViewCellDelegate?
    var dataSource: FoodTableViewCellDataSource?
    
    
    @IBOutlet fileprivate weak var typeImageView: UIImageView!
    @IBOutlet fileprivate weak var photoImageView: UIImageView!
    @IBOutlet fileprivate weak var title: UILabel!
    @IBOutlet fileprivate weak var descriptionLabel: UILabel!
    @IBOutlet fileprivate weak var availabiletyLable: UILabel!
    @IBOutlet fileprivate weak var favoriteButton: UIButton!
    @IBOutlet fileprivate weak var unlikeButton: UIButton!
    @IBOutlet fileprivate weak var likeButton: UIButton!
    @IBOutlet fileprivate weak var unlikeCountLabel: UILabel!
    @IBOutlet fileprivate weak var likecountLabel: UILabel!
    @IBOutlet fileprivate weak var expiredLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func onTapFavorite(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        guard let f = food else {
            return
        }
        delegate?.didSelectedFavorite(cell: self, favorite: sender.isSelected, food: f)
    }
    
    @IBAction func onTapLike(_ sender: Any) {
        guard let f = food else {
            return
        }
        delegate?.didLikeFood(cell: self, food: f)
    }
    
    @IBAction func onTapUnlike(_ sender: Any) {
        guard let f = food else {
            return
        }
        delegate?.didUnlikeFood(cell: self, food: f)
    }
}
