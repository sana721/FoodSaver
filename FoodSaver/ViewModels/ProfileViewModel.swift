//
//  ProfileViewModel.swift
//  FoodSaver
//
//  Created on 12/2/22.
//

import Foundation
import Foundation
import CoreLocation
import UIKit

class ProfileViewModel {
    
    var firstname = Observable("")
    var lastname = Observable("")
    var gender = Observable(Gender.Male)
    var address = Observable("")
    var latLong = Observable(CLLocationCoordinate2D())
    var aboutMe = Observable("")
    var photo: Observable<UIImage?> = Observable(nil)
    var phone = Observable("")
    var email = Observable("")
    
    var validationError = ""
    
    init() {
        let account = AppManager.manager.loginAccount
        let user = account?.user
        
        firstname.value = user?.firstname ?? ""
        lastname.value = user?.lastname ?? ""
        gender.value = Gender(rawValue: Int(user?.gender ?? 0)) ?? .Male
        address.value = user?.address ?? ""
        latLong.value = CLLocationCoordinate2D(latitude: user?.latitude ?? 0.0, longitude: user?.longitude ?? 0.0)
        aboutMe.value = user?.aboutMe ?? ""
        phone.value = user?.phone ?? ""
        email.value = user?.email ?? ""
        if let data = user?.photo as? NSData {
            photo.value = UIImage(data: data as Data)
        } else {
            photo.value = nil
        }
        
    }
    
    func isValide(completion: @escaping((Bool) -> ())) {
                
        guard firstname.value.isEmpty == false else {
            validationError = NSLocalizedString("Firstname should not be empty.", comment: "Firstname should not be empty.")
            return completion(false)
        }
        
        guard address.value.isEmpty == false else {
            validationError = NSLocalizedString("Address should not be empty.", comment: "Address should not be empty.")
            return completion(false)
        }
        
        guard phone.value.isEmpty == false else {
            validationError = NSLocalizedString("Phone number should not be empty.", comment: "Phone number should not be empty.")
            return completion(false)
        }
        
        guard email.value.isEmpty == false else {
            validationError = NSLocalizedString("email id should not be empty.", comment: "email id should not be empty.")
            return completion(false)
        }
        
        guard Utilities.isValidEmail(email.value) == true else {
            validationError = NSLocalizedString("Please enter proper email ID.", comment: "Please enter proper email ID.")
            return completion(false)
        }
        
        validateAddress { (result) in
            guard self.latLong.value.longitude != 0.0, self.latLong.value.latitude != 0.0 else {
                self.validationError = NSLocalizedString("Please enter complete address.", comment: "Please enter complete address.")
                return completion(false)
            }
            self.validationError = ""
            completion(true)
        }
    }
    
    func save(completion: @escaping((Bool) -> Void)) {
        isValide { (result) in
            guard result == true, let account = AppManager.manager.loginAccount else {
                return completion(false)
            }
            
            if let user = account.user {
                
                user.firstname = self.firstname.value
                user.lastname = self.lastname.value
                user.gender = Int16(self.gender.value.rawValue)
                user.aboutMe = self.aboutMe.value
                user.address = self.address.value
                user.latitude = self.latLong.value.latitude
                user.longitude = self.latLong.value.longitude
                user.phone = self.phone.value
                user.email = self.email.value
                user.photo = self.photo.value?.pngData() as NSObject?
                                
                DBManager.manager.saveContext()
            }
            completion(true)
        }
    }
    
    func validateAddress(completion: ((Bool) -> ())?) {
        guard address.value.isEmpty == false else {
            completion?(false)
            return
        }
        
        let geoCode = CLGeocoder()
        geoCode.geocodeAddressString(address.value) { (placemarks, error) in
            guard let placemark = placemarks?.first else {
                self.latLong.value = CLLocationCoordinate2D()
                completion?(false)
                return
            }
            self.latLong.value = placemark.location?.coordinate ?? CLLocationCoordinate2D()
            completion?(true)
        }
    }
}
