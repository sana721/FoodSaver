//
//  RequestTableViewCell.swift
//  FoodSaver
//
//  Created on 12/11/22.
//

import UIKit

protocol RequestTableViewCellDelegate {
    func requestCall(cell: RequestTableViewCell)
    func requestAccepted(cell: RequestTableViewCell)
    func requestDeclined(cell: RequestTableViewCell)
}

class RequestTableViewCell: UITableViewCell {

    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var foodImageView: UIImageView!
    @IBOutlet fileprivate weak var descLabel: UILabel!
    @IBOutlet fileprivate weak var statusLabel: UILabel!
    @IBOutlet fileprivate weak var noButton: UIButton!
    @IBOutlet fileprivate weak var yesButton: UIButton!
    @IBOutlet fileprivate weak var callButton: UIButton!
    
    var delegate: RequestTableViewCellDelegate? = nil
    
    
    var request: Request? {
        didSet{
            titleLabel.text = "\(request?.requester?.firstname ?? "") \(request?.requester?.lastname ?? "")"
            descLabel.text = "\(request?.quantity ?? 0) of \(request?.food?.title ?? "")"
            if let data = request?.food?.image {
                foodImageView.image = UIImage(data: data);
            } else {
                foodImageView.image = nil
            }
        }
    }
    
    func updateRequestStatus(status: RequestStatus, isDoner: Bool) {
        statusLabel.text = status.displayString()
        var statusColor = UIColor(named: "Text")
        switch status {
        case .Approved:
            statusColor = UIColor(named: "Like")
        case .Declined:
            statusColor = UIColor(named: "Unlike")
        default:
            break
        }
        statusLabel.textColor = statusColor
        if status != .Requested || isDoner == false {
            yesButton.isHidden = true
            noButton.isHidden = true
        } else  {
            yesButton.isHidden = false
            noButton.isHidden = false
        }
        callButton.isHidden = !isDoner
    }
    

    @IBAction func onTapCall(_ sender: Any) {
        delegate?.requestCall(cell: self)
    }
    
    @IBAction func onTapNo(_ sender: Any) {
        delegate?.requestDeclined(cell: self)
    }
    
    @IBAction func onTapYes(_ sender: Any) {
        delegate?.requestAccepted(cell: self)
    }
}
