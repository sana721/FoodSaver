//
//  ForgotPasswordViewController.swift
//  FoodSaver
//
//  Created on 04/12/22.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet fileprivate weak var usernameTextField: UITextField!
    @IBOutlet fileprivate weak var passwordTextField: UITextField!
    @IBOutlet fileprivate weak var confirmPasswordTextFoeld: UITextField!
    
    @IBAction func onTapSave(_ sender: UIBarButtonItem) {
        self.resignFirstResponder()
        
        if usernameTextField.text?.isEmpty == true {
            showInfoAlert(title: NSLocalizedString("Error", comment: "Error"), message: NSLocalizedString("Username filed should not be empty.", comment: "Username filed should not be empty."), completion: nil)
            return
        }
        
        if passwordTextField.text?.isEmpty == true {
            showInfoAlert(title: NSLocalizedString("Error", comment: "Error"), message: NSLocalizedString("Password filed should not be empty.", comment: "Password filed should not be empty."), completion: nil)
            return
        }
        
        if passwordTextField.text != confirmPasswordTextFoeld.text {
            showInfoAlert(title: NSLocalizedString("Error", comment: "Error"), message: NSLocalizedString("Password  and confirm password should be same.", comment: "Password  and confirm password should be same."), completion: nil)
            return
        }
        
        if let username = usernameTextField.text,
            let account = DBManager.manager.accountForUsername(username: username),
            let pwd = passwordTextField.text {
            account.password = pwd
            DBManager.manager.saveContext()
            self.navigationController?.popViewController(animated: true)
        } else {
            showInfoAlert(title: NSLocalizedString("Error", comment: "Error"), message: NSLocalizedString("User not found. Please check the username", comment: "User not found. Please check the username"), completion: nil)
            return
        }
    }
}
