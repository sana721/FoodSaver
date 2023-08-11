//
//  Food+Extensions.swift
//  FoodSaver
//
//  Created on 13/11/22.
//

import Foundation

extension Food {
    func isExpired() -> Bool {
        if let pDate = postDate {
            return !Calendar.current.isDateInToday(pDate)
        }
        return true
    }
}
