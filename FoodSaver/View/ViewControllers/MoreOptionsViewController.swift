//
//  MoreOptionsViewController.swift
//  FoodSaver
//
//  Created on 03/11/22.
//

import UIKit

enum MoreOptions: Int, CaseIterable{
    case share
    case logout
    
    func displayString() -> String {
        switch self {
        case .logout:
            return NSLocalizedString("Logout", comment: "Logout")
        case .share:
            return NSLocalizedString("Share", comment: "Share")
        }
    }
    
    func icon() -> UIImage? {
        switch self {
        case .logout:
            return #imageLiteral(resourceName: "logout")
        case .share:
            return #imageLiteral(resourceName: "share")
        }
    }
}

class MoreOptionsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension MoreOptionsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MoreOptions.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MoreOptionsTableViewCell") as?  MoreOptionsTableViewCell {
            cell.title = MoreOptions(rawValue: indexPath.row)?.displayString() ?? "-"
            cell.imageView?.image = MoreOptions(rawValue: indexPath.row)?.icon()
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let opt = MoreOptions(rawValue: indexPath.row) else {
            return
        }
        
        switch opt {
        case .logout:
            AppManager.manager.loginAccount = nil
            if let login = self.storyboard?.instantiateInitialViewController() {
                UIApplication.shared.keyWindow?.rootViewController = login
            }
        case .share:
            let firstActivityItem = NSLocalizedString("Hi!, I'm using FoodSaver app to serve food for the needy. Check it out.", comment: "Hi!, I'm using FoodSaver app to serve food for the needy. Check it out.")

            let activityViewController : UIActivityViewController = UIActivityViewController(
                activityItems: [firstActivityItem], applicationActivities: nil)
            

            activityViewController.excludedActivityTypes = [
//                UIActivity.ActivityType.postToWeibo,
//                UIActivity.ActivityType.print,
//                UIActivity.ActivityType.assignToContact,
//                UIActivity.ActivityType.saveToCameraRoll,
//                UIActivity.ActivityType.addToReadingList,
                UIActivity.ActivityType.postToFlickr,
                UIActivity.ActivityType.postToVimeo,
                UIActivity.ActivityType.postToTencentWeibo,
                UIActivity.ActivityType.postToFacebook
            ]
            
            self.present(activityViewController, animated: true, completion: nil)
        }
    }
}
