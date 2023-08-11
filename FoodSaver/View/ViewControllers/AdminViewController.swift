//
//  AdminViewController.swift
//  FoodSaver
//
//  Created on 04/12/22.
//

import UIKit

class AdminViewController: UIViewController {

    @IBOutlet fileprivate weak var tableView: UITableView!
    fileprivate let viewModel = AdminViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModel.loadAccounts()
        tableView.reloadData()
    }
    
    @IBAction func onTapLogout(_ sender: UIButton) {
        AppManager.manager.loginAccount = nil
        if let login = self.storyboard?.instantiateInitialViewController() {
            UIApplication.shared.keyWindow?.rootViewController = login
        }
    }
}

extension AdminViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {        
        let count = viewModel.accounts.count
        if count > 0 {
            tableView.backgroundView = nil
            return count
        } else {
            tableView.backgroundView = Utilities.noRecordLabel()
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AccountTableViewCell") as? AccountTableViewCell else {
            return UITableViewCell()
        }
        
        cell.account = viewModel.accounts[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let account = viewModel.accounts[indexPath.row]
        let activeTitle = account.isActive ? NSLocalizedString("Inactivate", comment: "Inactivate") : NSLocalizedString("Activate", comment: "Activate")
        let activeAction = UIContextualAction(style: .normal, title: activeTitle) { (action, view, handler) in
            self.viewModel.active(account: account, active: !account.isActive)
            handler(true)
        }
        
        let deleteAction = UIContextualAction(style: .destructive, title: NSLocalizedString("Delete", comment: "Delete")) { (action, view, handler) in
            self.viewModel.delete(account: account)
            self.viewModel.loadAccounts()
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            handler(true)
        }
        return UISwipeActionsConfiguration(actions: [activeAction, deleteAction])
    }
    
    
}
