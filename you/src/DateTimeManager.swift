//
//  DateTimeManager.swift
//  you
//
//  Created by Jun Zhou on 10/20/18.
//  Copyright © 2018 jzhou. All rights reserved.
//

import Foundation

class DateTimeManager {
    static let birthDateFormat = "MM/dd/yyyy"
    
    static func convertDateToString(date: Date) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = birthDateFormat
        let myString = formatter.string(from: date)
        return myString
    }
    
    static func convertStringToDate(date: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = birthDateFormat
        let myDate = formatter.date(from: date)
        return myDate
    }
}
