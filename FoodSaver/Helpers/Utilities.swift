//
//  Utilities.swift
//  FoodSaver
//
//  Created on 18/09/22.
//

import Foundation
import UIKit

class Utilities {
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    static func noRecordLabel() -> UILabel {
             let label = UILabel()
             label.text = NSLocalizedString("No records found.", comment: "No records found.")
             label.textColor = UIColor(named: "Text")
             label.font = UIFont.systemFont(ofSize: 11.0)
             label.textAlignment = .center
             return label
         }
}
