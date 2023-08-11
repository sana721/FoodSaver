//
//  ViewController.swift
//  FoodSaver
//
//  Created on 18/09/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet fileprivate weak var usernameTextField: UITextField!
    @IBOutlet fileprivate weak var passwordTextField: UITextField!
    
    var viewModel = LoginViewModel(){
        didSet {
            viewModel.username.bind { (username) in
                self.usernameTextField.text = username
            }
            
            viewModel.password.bind { (password) in
                self.passwordTextField.text = password
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func onTapLogin(_ sender: UIButton) {
        viewModel.username.value = usernameTextField.text ?? ""
        viewModel.password.value = passwordTextField.text ?? ""
        viewModel.doLogin { (error) in
            guard error == nil else {
                return self.showInfoAlert(title: NSLocalizedString("Error", comment: "Error"), message: error?.localizedDescription, completion: nil)
            }
            
            if self.usernameTextField.text == "admin",
                let admin = self.storyboard?.instantiateViewController(withIdentifier: "AdminNavigationViewController") {
                    UIApplication.shared.keyWindow?.rootViewController = admin
                
            } else if let home = self.storyboard?.instantiateViewController(withIdentifier: "HomeTabTarViewController") as? HomeTabTarViewController {
                UIApplication.shared.keyWindow?.rootViewController = home
            }
        }
    }
    
    @IBAction func onTapSignup(_ sender: UIButton) {
    }
    
    @IBAction func onTapForgotPassword(_ sender: UIButton) {
    }

}

