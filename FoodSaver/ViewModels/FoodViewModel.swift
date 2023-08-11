//
//  FoodViewModel.swift
//  FoodSaver
//
//  Created on 05/11/22.
//

import Foundation

class FoodViewModel {
    
    fileprivate(set) var food: Observable<[Food]> = Observable([])
    fileprivate(set) var favoriteFoods: Observable<[Food]> = Observable([])
    fileprivate(set) var sourceFavoriteFoods: [Food] = []
    fileprivate(set) var sourceFood: [Food] = []
    fileprivate(set) var filter: FoodFilter = .all
    
    func loadAllAvialabelFood() {
        guard let account = AppManager.manager.loginAccount else {
            self.food.value = []
            return
        }
        let foods = DBManager.manager.getAllFoodItems(account: account)
        sourceFood = foods.sorted(by: { (f1, f2) -> Bool in
            if let d1 = f1.postDate, let d2 = f2.postDate {
                return d1 > d2
            }
            return false
        })
        applyFilter(filter: filter)
    }
    
    func loadAllFavoriteFoodItems() {
        guard let account = AppManager.manager.loginAccount,
            let favorites = account.user?.myFavorites?.allObjects as? [Food] else {
            self.favoriteFoods.value = []
            return
        }
        
        sourceFavoriteFoods = favorites.sorted(by: { (f1, f2) -> Bool in
            if let d1 = f1.postDate, let d2 = f2.postDate {
                return d1 > d2
            }
            return false
        })
        applyFilter(filter: filter)
    }
    
    func applyFilter(filter: FoodFilter) {
        if !sourceFood.isEmpty {
            if filter == .all {
                self.food.value = sourceFood
            } else {
                self.food.value = sourceFood.filter({ (f) -> Bool in
                    return f.isVeg == (filter == .veg)
                })
            }
        } else {
            food.value = []
        }
        
        if !sourceFavoriteFoods.isEmpty {
            if filter == .all {
                self.favoriteFoods.value = sourceFavoriteFoods
            } else {
                self.favoriteFoods.value = sourceFavoriteFoods.filter({ (f) -> Bool in
                    return f.isVeg == (filter == .veg)
                })
            }
        } else {
            favoriteFoods.value = []
        }
    }
    
    func addToFavorites(add: Bool, food: Food) {
        if add {
            AppManager.manager.loginAccount?.user?.addToMyFavorites(food)
        } else {
            AppManager.manager.loginAccount?.user?.removeFromMyFavorites(food)
        }
        DBManager.manager.saveContext()
    }
    
    func addLike(food: Food) {
        food.likes += 1
        DBManager.manager.saveContext()
    }
    
    func addUnlike(food: Food) {
        food.dislike += 1
        DBManager.manager.saveContext()
    }
    
    func isFoodFavorite(food: Food) -> Bool {
        return AppManager.manager.loginAccount?.user?.myFavorites?.contains(food) ?? false
    }
}
