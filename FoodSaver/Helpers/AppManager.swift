//
//  AppManager.swift
//  FoodSaver
//
//  Created on 18/09/22.
//

import Foundation
import NVActivityIndicatorView

class AppManager {
    
    static let manager = AppManager()
    fileprivate var activityIndicatorView: NVActivityIndicatorView?
    
    var loginAccount: Account?
    
    private init() {
        
    }
    
    func showActivityIndicator(on view: UIView) {
        guard activityIndicatorView == nil, activityIndicatorView?.isAnimating == false else {
            return
        }
        
        activityIndicatorView = NVActivityIndicatorView(frame: view.bounds, type: .ballPulse, color: NVActivityIndicatorView.DEFAULT_COLOR, padding: NVActivityIndicatorView.DEFAULT_PADDING)
        activityIndicatorView?.startAnimating()
    }
    
    func stopActivityIndicator() {
        activityIndicatorView?.startAnimating()
        activityIndicatorView = nil
    }
}
