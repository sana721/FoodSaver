//
//  RequestsViewModel.swift
//  FoodSaver
//
//  Created on 12/11/22.
//

import Foundation

class RequestsViewModel {
    fileprivate(set) var requests: [Request] = []
    
    func phoneNumber(request: Request?) -> String {
        return request?.requester?.phone ?? ""
    }
    
    func accpet(request: Request?) -> Bool {
        guard let r = request, let f = r.food else {
            return false
        }
        
        let availableFood = f.quantity - f.donatedQuantity
        if r.quantity <= availableFood {
            f.donatedQuantity += r.quantity
            r.status = Int16(RequestStatus.Approved.rawValue)
            DBManager.manager.saveContext()
            return true
        }
        
        return false
    }
    
    func decline(request: Request?) -> Bool {
        guard let r = request else {
            return false
        }
        
        r.status = Int16(RequestStatus.Declined.rawValue)
        DBManager.manager.saveContext()
        return true
    }
    
    func updateRequestStatus(request: Request) {
        guard request.status == Int16(RequestStatus.Requested.rawValue),
            let f = request.food else {
            return
        }
        
        let availableFood = f.quantity - f.donatedQuantity
        if request.quantity > availableFood || f.isExpired() {
            request.status = Int16(RequestStatus.Declined.rawValue)
            DBManager.manager.saveContext()
        }
    }
    
    func loadRequests() {
        guard let account = AppManager.manager.loginAccount else {
            requests = []
            return
        }
        
        if account.account_type == AccountType.Donor.rawValue {
            requests = DBManager.manager.getAllRequestsForTo(account: account)
        } else if account.account_type == AccountType.Receiver.rawValue {
            requests = DBManager.manager.getAllRequestsBy(account: account)
        } else {
            requests = []
        }
        
        requests = requests.sorted(by: { (r1, r2) -> Bool in
            if let d1 = r1.date, let d2 = r2.date {
                return d1 > d2
            }
            return false
        })
    }
}
