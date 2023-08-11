//
//  AdminViewModel.swift
//  FoodSaver
//
//  Created on 06/12/22.
//

import Foundation

class AdminViewModel {
    fileprivate(set) var accounts: [Account] = []
    
    func loadAccounts() {
        accounts = DBManager.manager.getAllAccounts()
    }
    
    func active(account: Account, active: Bool) {
        account.isActive = active
        DBManager.manager.saveContext()
    }
    
    func delete(account: Account) {
        DBManager.manager.deleteEntity(entity: account)
        DBManager.manager.saveContext()
    }
}
