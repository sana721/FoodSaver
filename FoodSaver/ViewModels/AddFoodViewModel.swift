//
//  AddFoodViewModel.swift
//  FoodSaver
//
//  Created on 02/11/22.
//

import Foundation
import UIKit

class AddFoodViewModel {
    var title = Observable("")
    var quantity = Observable(1)
    var type = Observable(FoodType.veg)
    var description = Observable("")
    var photo: Observable<UIImage?> = Observable(nil)
    fileprivate(set) var addedFood: Food? = nil
    
    var validationError = ""
    
    func isValid() -> Bool {
        guard title.value.isEmpty == false else {
            validationError = NSLocalizedString("Title should not be empty.", comment: "Title should not be empty.")
            return false
        }
        
        guard quantity.value > 0 else {
            validationError = NSLocalizedString("Quantity should not be empty.", comment: "Quantity should not be empty.")
            return false
        }
        
        guard description.value.isEmpty == false else {
            validationError = NSLocalizedString("Food Description should not be empty.", comment: "Food Description should not be empty.")
            return false
        }
        
        guard photo.value != nil else {
            validationError = NSLocalizedString("Please attach a photo of the food.", comment: "Please attach a photo of the food.")
            return false
        }
        
        validationError = ""
        return true
    }
    
    func save() -> Bool {
        guard isValid() == true else {
            return false
        }
        
        if let food = DBManager.manager.newEntity(entity: .Food) as? Food {
            food.title = title.value
            food.quantity = Int16(quantity.value)
            food.isVeg = type.value == .veg
            food.postDate = Date()
            food.image = photo.value?.jpegData(compressionQuality: 1.0)
            food.desc = description.value
            
            if let user = AppManager.manager.loginAccount?.user {
                user.addToDonatedFoods(food)
                DBManager.manager.saveContext()
                validationError = ""
                return true
                addedFood = food
            } else {
                DBManager.manager.rollback()
            }
        }
        
        validationError = NSLocalizedString("Something went wrong. Please try again.", comment: "Something went wrong. Please try again.")
        return false
    }
}
