//
//  AddFoodViewController.swift
//  FoodSaver
//
//  Created on 02/11/22.
//

import UIKit

class AddFoodViewController: UIViewController {
    @IBOutlet fileprivate weak var titleTextField: UITextField!
    @IBOutlet fileprivate weak var typeTextField: UITextField!
    @IBOutlet fileprivate weak var quantityTextField: UITextField!
    @IBOutlet fileprivate weak var photoButton: UIButton!
    
    @IBOutlet fileprivate weak var descriptionTextView: UITextView!
    
    var foodTypePickerView = UIPickerView()
    var quantityPickerView = UIPickerView()
    
    var viewModel = AddFoodViewModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        
        foodTypePickerView.delegate = self
        foodTypePickerView.dataSource = self
        quantityPickerView.delegate = self
        quantityPickerView.dataSource = self
        
        typeTextField.inputView = foodTypePickerView
        quantityTextField.inputView = quantityPickerView
    }
    
    @IBAction func onTapPhoto(_ sender: UIButton) {
        showAlert()
    }
    
    @IBAction func onTapSave(_ sender: UIBarButtonItem) {
        updateViewModel()
        if viewModel.save() {
            navigationController?.popViewController(animated: true)
        } else {
            showInfoAlert(title: NSLocalizedString("Error", comment: "Error"), message: viewModel.validationError, completion: nil)
        }
    }
}

extension AddFoodViewController {
    func bindViewModel() {
        viewModel.title.bind { (title) in
            self.titleTextField.text = title
        }
        
        viewModel.quantity.bind { (q) in
            self.quantityTextField.text = "\(q)"
        }
        
        viewModel.type.bind { (t) in
            self.typeTextField.text = t.displayString()
        }
        
        viewModel.description.bind { (dec) in
            self.descriptionTextView.text = dec
        }
        
        viewModel.photo.bind { (p) in
            self.photoButton.setBackgroundImage(p, for: .normal)
        }
        
        titleTextField.text = viewModel.title.value
        quantityTextField.text = "\(viewModel.quantity.value)"
        typeTextField.text = viewModel.type.value.displayString()
        descriptionTextView.text = viewModel.description.value
        photoButton.setBackgroundImage(viewModel.photo.value ?? UIImage(named: "food") , for: .normal)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Image Selection", message: "From where you want to pick this image?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func updateViewModel() {
        viewModel.title.value = titleTextField.text ?? ""
        viewModel.description.value = descriptionTextView.text ?? ""
    }
}

extension AddFoodViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if pickerView == foodTypePickerView {
            return FoodType.allCases.count
        } else if pickerView == quantityPickerView {
            return 100
        }
        return 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == foodTypePickerView, let type = FoodType(rawValue: row) {
            return type.displayString()
        } else if pickerView == quantityPickerView {
            return "\(row + 1)"
        }
        return ""
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == foodTypePickerView, let type = FoodType(rawValue: row) {
            self.viewModel.type.value = type
        } else if pickerView == quantityPickerView {
            self.viewModel.quantity.value = row + 1
        }
    }
}

extension AddFoodViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    private func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {

        //Check is source type available
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {

            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = sourceType
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        self.dismiss(animated: true) { [weak self] in

            guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
            self?.viewModel.photo.value = image
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
