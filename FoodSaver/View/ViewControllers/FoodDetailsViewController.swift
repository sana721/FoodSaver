//
//  FoodDetailsViewController.swift
//  FoodSaver
//
//  Created on 06/11/22.
//

import UIKit
import CoreLocation
import MapKit

class FoodDetailsViewController: UIViewController {
    
    @IBOutlet fileprivate weak var imageView: UIImageView!
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var descriptionTextView: UITextView!
    @IBOutlet fileprivate weak var foodTypeImageView: UIImageView!
    @IBOutlet fileprivate weak var availableFoodLabel: UILabel!
    @IBOutlet fileprivate weak var unlikesLabel: UILabel!
    @IBOutlet fileprivate weak var likesLabel: UILabel!
    @IBOutlet fileprivate weak var quantityTextField: UITextField!
    @IBOutlet fileprivate weak var favoriteButton: UIButton!
    @IBOutlet fileprivate weak var donatedByLabel: UILabel!
    @IBOutlet fileprivate weak var expiredLabel: UILabel!
    @IBOutlet fileprivate weak var requestButton: UIButton!
    @IBOutlet fileprivate weak var likeButton: UIButton!
    @IBOutlet fileprivate weak var unlikeButton: UIButton!
    
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    var food: Food? = nil {
        didSet {
            if let f = food {
                viewModel = FoodDetailsViewModel(food: f)
            } else {
                viewModel = nil
            }
        }
    }
    
    fileprivate(set) var viewModel: FoodDetailsViewModel? = nil
    fileprivate(set) var quantityPickerView = UIPickerView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateFoodData()
        quantityTextField.inputView = quantityPickerView
        quantityPickerView.delegate = self
        bindViewModel()
        if AppManager.manager.loginAccount?.account_type == Int16(AccountType.Receiver.rawValue) {
            self.navigationItem.rightBarButtonItem = nil
        } else {
            quantityTextField.isUserInteractionEnabled = false
            requestButton.isEnabled = false
            likeButton.isEnabled = false
            unlikeButton.isEnabled = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.loadAllReviews()
        tableView.reloadData()
        
    }
    
    @IBAction func onTapFavorite(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        viewModel?.addToFavorites(add: sender.isSelected)
        updateFoodData()
    }
    
    @IBAction func onTapLike(_ sender: Any) {
        viewModel?.addLike()
        updateFoodData()
    }
    
    @IBAction func onTapDelete(_ sender: Any) {
        showConfirmationAlert(title: NSLocalizedString("Delete", comment: "Delete"), message: NSLocalizedString("Do you want to delete this food?", comment: "Do you want to delete this food?"), accpetBlock: {
            if self.viewModel?.deleteFood() ?? false {
                self.navigationController?.popViewController(animated: true)
            } else {
                self.showInfoAlert(title: NSLocalizedString("Error", comment: "Error"), message: NSLocalizedString("Something went wrong. Please try again.", comment: "Something went wrong. Please try again."), completion: nil)
            }
        }) {
            
        }
    }
    
    @IBAction func onTapCall(_ sender: Any) {
        if let url = URL(string: "tel://\(viewModel?.donorPhoneNumber() ?? "")"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func onTapDirection(_ sender: Any) {
        let regionDistance:CLLocationDistance = 10000
        let coordinates = viewModel?.donorLocation() ?? CLLocationCoordinate2DMake(0.0, 0.0)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = viewModel?.donorName() ?? ""
        mapItem.openInMaps(launchOptions: options)
    }
    
    @IBAction func onTapUnlike(_ sender: Any) {
        viewModel?.addUnlike()
        updateFoodData()
    }
    
    @IBAction func onTapWriteReview(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(identifier: "ReviewViewController") as? ReviewViewController {
            vc.food = food
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func onTapRequest(_ sender: Any) {
        if viewModel?.requestFood() ?? false {
            showInfoAlert(title: NSLocalizedString("Success", comment: "Success"), message: NSLocalizedString("Requested sucecssfully. Please wait for the confirmation.", comment: "Requested sucecssfully. Please wait for the confirmation.")) {
                self.navigationController?.popViewController(animated: true)
            }
        } else {
            showInfoAlert(title: NSLocalizedString("Failed", comment: "Failed"), message: NSLocalizedString("Something went wrong. Raise request with right quantity and train again.", comment: "Something went wrong. Raise request with right quantity and train again.")) {
            }
        }
    }
}

fileprivate extension FoodDetailsViewController {
    func updateFoodData()  {
        if let data = food?.image {
            imageView.image = UIImage(data: data)
        } else {
            imageView.image = nil
        }
        titleLabel.text = food?.title
        descriptionTextView.text = food?.desc
        favoriteButton.isSelected = viewModel?.isFoodFavorite() ?? false
        likesLabel.text = "\(food?.likes ?? 0)"
        unlikesLabel.text = "\(food?.dislike ?? 0)"
        availableFoodLabel.text = "\(viewModel?.avialbleQuantity() ?? 0) / \(food?.quantity ?? 0)"
        foodTypeImageView.tintColor = (food?.isVeg ?? true) ? UIColor(named: "veg") : UIColor(named: "nonveg")
        favoriteButton.isSelected = viewModel?.isFoodFavorite() ?? false
        donatedByLabel.text = "By \(viewModel?.donorName() ?? ""), \(viewModel?.donorAddress() ?? "")"
        expiredLabel.isHidden = !(food?.isExpaired() ?? false)
    }
    
    func bindViewModel() {
        viewModel?.requestQuantity.bind({ (v) in
            self.quantityTextField.text = "\(v)"
        })
        quantityTextField.text = "\(viewModel?.requestQuantity.value ?? 0)"
    }
}

extension FoodDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.reviews.value.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewTableViewCell") as? ReviewTableViewCell else {
            return UITableViewCell()
        }
        let review = viewModel?.reviews.value[indexPath.row]
        cell.review = review
        return cell
    }
}

extension FoodDetailsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        let count = viewModel?.avialbleQuantity() ?? 0
        if count > 0 {
            tableView.backgroundView = nil
            return count
        } else {
            tableView.backgroundView = Utilities.noRecordLabel()
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row + 1)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel?.requestQuantity.value = row + 1
    }
}
