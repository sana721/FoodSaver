//
//  LoginViewModel.swift
//  FoodSaver
//
//  Created on 01/10/22.
//

import Foundation

class LoginViewModel {
    
    var username: Observable<String> = Observable("")
    var password: Observable<String> = Observable("")
    
    func doLogin(completion: @escaping(Error?) -> ()) {
        validate { (error) in
            guard error == nil else {
                return completion(error)
            }
            
            if self.username.value == "admin",
                self.password.value == "admin" {
                return completion(nil)
            }
            
            guard let account = DBManager.manager.accountForUsername(username: self.username.value)  else {
                return completion(NSError(domain: "Error", code: -1, userInfo: [NSLocalizedDescriptionKey : NSLocalizedString("User not available.", comment: "User not available.")]))
            }
            
            if account.password == self.password.value {
                guard account.isActive else {
                    return completion(NSError(domain: "Error", code: -1, userInfo: [NSLocalizedDescriptionKey : NSLocalizedString("Your account is inactive. Please contact admin.", comment: "Your account is inactive. Please contact admin.")]))
                }
                AppManager.manager.loginAccount = account
                return completion(nil)
            }
            return completion(NSError(domain: "Error", code: -1, userInfo: [NSLocalizedDescriptionKey : NSLocalizedString("Please enter correct password.", comment: "Please enter correct password.")]))
        }
    }
    
    func validate(completion: @escaping(Error?) -> ()) {
        guard username.value.isEmpty == false else {
            return completion(NSError(domain: "Error", code: -1, userInfo: [NSLocalizedDescriptionKey : NSLocalizedString("Username should not be empty.", comment: "Username should not be empty.")]))
        }
        
        guard password.value.isEmpty == false else {
            return completion(NSError(domain: "Error", code: -1, userInfo: [NSLocalizedDescriptionKey : NSLocalizedString("Password should not be empty.", comment: "Password should not be empty.")]))
        }
        completion(nil)
    }
}
 
