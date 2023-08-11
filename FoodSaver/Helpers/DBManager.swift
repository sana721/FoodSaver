//
//  DBManager.swift
//  FoodSaver
//
//  Created on 01/10/22.
//

import Foundation
import CoreData

class DBManager {
    
    enum Entities: String {
        case Account = "Account"
        case Food = "Food"
        case Request = "Request"
        case Review = "Review"
        case User = "User"
    }
    
    static let manager = DBManager()
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "FoodSaver")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private init() {
        
    }
    
    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func deleteEntity(entity: NSManagedObject) {
        persistentContainer.viewContext.delete(entity)
        saveContext()
    }
    
    func rollback()  {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            context.rollback()
        }
    }
    
    func newEntity(entity: Entities) -> NSManagedObject {
        return NSEntityDescription.insertNewObject(forEntityName: entity.rawValue, into: persistentContainer.viewContext)
    }
    
    func accountForUsername(username: String) -> Account? {
        let fetchRequest: NSFetchRequest<Account> = Account.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "username == %@", username)
        return try? persistentContainer.viewContext.fetch(fetchRequest).first
    }
    
    func getAllAccounts() -> [Account] {
        let fetchRequest: NSFetchRequest<Account> = Account.fetchRequest()
        return (try? persistentContainer.viewContext.fetch(fetchRequest)) ?? []
    }
    
    func getAllFoodItems(account: Account) -> [Food] {
        let fetchRequest: NSFetchRequest<Food> = Food.fetchRequest()
        if account.account_type == AccountType.Donor.rawValue {
            fetchRequest.predicate = NSPredicate(format: "donor.account.username == %@", account.username ?? "")
        }
        return (try? persistentContainer.viewContext.fetch(fetchRequest)) ?? []
    }
    
    func getAllRequestsForTo(account: Account) -> [Request] {
        let fetchRequest: NSFetchRequest<Request> = Request.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "food.donor.account.username == %@", account.username ?? "")
        return (try? persistentContainer.viewContext.fetch(fetchRequest)) ?? []
    }
    
    func getAllRequestsBy(account: Account) -> [Request] {
        let fetchRequest: NSFetchRequest<Request> = Request.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "requester.account.username == %@", account.username ?? "")
        return (try? persistentContainer.viewContext.fetch(fetchRequest)) ?? []
    }
}

fileprivate extension DBManager {

}
