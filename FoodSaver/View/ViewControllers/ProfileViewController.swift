//
//  ProfileViewController.swift
//  FoodSaver
//
//  Created on 17/11/22.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet fileprivate weak var firstnameTextField: UITextField!
    @IBOutlet fileprivate weak var lastnameTextField: UITextField!
    @IBOutlet fileprivate weak var photoButton: UIButton!
    @IBOutlet fileprivate weak var genderTextField: UITextField!
    @IBOutlet fileprivate weak var phoneNumberTextField: UITextField!
    @IBOutlet fileprivate weak var emailIDTextField: UITextField!
    @IBOutlet fileprivate weak var addressTextField: UITextField!
    @IBOutlet fileprivate weak var latLangLabel: UILabel!
    @IBOutlet fileprivate weak var aboutMeTextView: UITextView!
    
    fileprivate(set) var genderPickerView = UIPickerView()
    
    fileprivate var viewModel = ProfileViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        bindViewModel()
        genderPickerView.delegate = self
        genderPickerView.dataSource = self
        genderTextField.inputView = genderPickerView
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = AppManager.manager.loginAccount?.username ?? NSLocalizedString("Profile", comment: "Profile")
        navigationController?.navigationBar.sizeToFit()
    }
    
    @IBAction func onTapPhoto(_ sender: UIButton) {
        showAlert()
    }
    
    @IBAction func onTapSave(_ sender: UIBarButtonItem) {
        self.resignFirstResponder()
        updateViewModel()
        AppManager.manager.showActivityIndicator(on: view)
        self.viewModel.isValide { (status) in
            AppManager.manager.stopActivityIndicator()
            if status {
                self.viewModel.save { (status) in
                    if status {
                        self.showInfoAlert(title: NSLocalizedString("Success", comment: "Success"), message: NSLocalizedString("Profile data saved.", comment: "Profile data saved."), completion: nil)
                    } else {
                        self.showInfoAlert(title: NSLocalizedString("Error", comment: "Error"), message: NSLocalizedString("Something went wrong. Please try again.", comment: "Something went wrong. Please try again."), completion: nil)
                    }
                }
            } else {
                self.showInfoAlert(title: NSLocalizedString("Error", comment: "Error"), message: self.viewModel.validationError, completion: nil)
            }
        }
    }
    
    @IBAction func onTapVerifyAddress(_ sender: UIButton) {
        updateViewModel()
        self.viewModel.validateAddress(completion: nil)
    }
}

extension ProfileViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
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

extension ProfileViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return Gender.allCases.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Gender(rawValue: row)?.displayString() ?? ""
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let gender = Gender(rawValue: row) {
            viewModel.gender.value = gender
        }
    }
}

private extension ProfileViewController {
    func bindViewModel() {
        genderTextField.text = viewModel.gender.value.displayString()
        firstnameTextField.text = viewModel.firstname.value
        lastnameTextField.text = viewModel.lastname.value
        photoButton.setBackgroundImage(viewModel.photo.value, for: .normal)
        phoneNumberTextField.text = viewModel.phone.value
        emailIDTextField.text = viewModel.email.value
        addressTextField.text = viewModel.address.value
        latLangLabel.text = String(format: "Lat: %.5f Long: %.5f", viewModel.latLong.value.latitude, viewModel.latLong.value.longitude)
        aboutMeTextView.text = viewModel.aboutMe.value
        
        viewModel.firstname.bind { (fname) in
            self.firstnameTextField.text = fname
        }
        
        viewModel.lastname.bind { (lname) in
            self.lastnameTextField.text = lname
        }
        
        viewModel.gender.bind { (g) in
            self.genderTextField.text = g.displayString()
        }
        
        viewModel.phone.bind { (p) in
            self.phoneNumberTextField.text = p
        }
        
        viewModel.email.bind { (e) in
            self.emailIDTextField.text = e
        }
        
        viewModel.address.bind { (add) in
            self.addressTextField.text = add
        }
        
        viewModel.aboutMe.bind { (aMe) in
            self.aboutMeTextView.text = aMe
        }
        
        viewModel.photo.bind { (p) in
            self.photoButton.setBackgroundImage(p, for: .normal)
        }
        
        viewModel.latLong.bind { (location) in
            self.latLangLabel.text = String(format: "Lat: %.5f Long: %.5f", location.latitude, location.longitude)
        }
    }
    
    func updateViewModel() {
        viewModel.firstname.value = firstnameTextField.text ?? ""
        viewModel.lastname.value = lastnameTextField.text ?? ""
        viewModel.gender.value = Gender.valueFrom(string: genderTextField.text ?? "")
        viewModel.photo.value = photoButton.backgroundImage(for: .normal)
        viewModel.address.value = addressTextField.text ?? ""
        viewModel.aboutMe.value = aboutMeTextView.text
        viewModel.phone.value = phoneNumberTextField.text ?? ""
        viewModel.email.value = emailIDTextField.text ?? ""
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
}
