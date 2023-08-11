//
//  RequestsViewController.swift
//  FoodSaver
//
//  Created on 02/11/22.
//

import UIKit

class RequestsViewController: UIViewController {

    @IBOutlet fileprivate weak var tableView: UITableView!
    
    fileprivate var viewModel = RequestsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
//        title = NSLocalizedString("Requests", comment: "Requests")
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor(named: "Screen Title") as Any]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.loadRequests()
        tableView.reloadData()
    }
}

extension RequestsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewModel.requests.count
        if count > 0 {
            tableView.backgroundView = nil
            return count
        } else {
            tableView.backgroundView = Utilities.noRecordLabel()
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RequestTableViewCell") as? RequestTableViewCell else {
            return UITableViewCell()
        }
        let request = viewModel.requests[indexPath.row]
        let status = RequestStatus(rawValue: Int(request.status)) ?? RequestStatus.Requested
        cell.updateRequestStatus(status: status, isDoner: AppManager.manager.loginAccount?.account_type == Int16(AccountType.Donor.rawValue))
        viewModel.updateRequestStatus(request: request)
        cell.request = request
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let food = viewModel.requests[indexPath.row].food
        if let vc = storyboard?.instantiateViewController(identifier: "FoodDetailsViewController") as? FoodDetailsViewController {
            self.navigationController?.pushViewController(vc, animated: true)
            vc.food = food
        }
    }
}

extension RequestsViewController: RequestTableViewCellDelegate {
    func requestCall(cell: RequestTableViewCell) {
        if let url = URL(string: "tel://\(viewModel.phoneNumber(request: cell.request))"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func requestAccepted(cell: RequestTableViewCell) {
        if viewModel.accpet(request: cell.request) {
            tableView.reloadData()
        } else {
            showInfoAlert(title: NSLocalizedString("Error", comment: "Error"), message: NSLocalizedString("Something went wrong. Please try again.", comment: "Something went wrong. Please try again."), completion: nil)
        }
    }
    
    func requestDeclined(cell: RequestTableViewCell) {
        if viewModel.decline(request: cell.request) {
            tableView.reloadData()
        } else {
            showInfoAlert(title: NSLocalizedString("Error", comment: "Error"), message: NSLocalizedString("Something went wrong. Please try again.", comment: "Something went wrong. Please try again."), completion: nil)
        }
    }
}
