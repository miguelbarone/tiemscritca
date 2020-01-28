//
//  Date+Extensions.swift
//  Time Tracking
//
//  Created by Marlon Morato on 16/01/20.
//  Copyright © 2020 ios-estags-iteris. All rights reserved.
//

import Foundation

extension Date {
    var shortDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateString = dateFormatter.string(from: self)

        return dateString
    }
    
    var shortTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let timeString = dateFormatter.string(from: self)
    
        return timeString
    }
    
    func shortStringTime(hour: Int, minute: Int) -> String {
        let HH = hour < 10 ? "0\(String(hour))" : String(hour)
        let mm = minute < 10 ? "0\(String(minute))" : String(minute)
        
        return "\(HH):\(mm)"
    }
    
    func hoursInterval(from: Date, to: Date) -> [Int] {
        let _interval: Int = Int(Date.distance(from: from, to: to))
        let hours: Int = _interval / 60 / 60 
        // let hh: String = hours < 10 ? "0\(String(hours))" : String(hours)
        let min: Int = (_interval / 60) % 60
        // let mm = min < 10 ? "0\(String(min))" : String(min)
        
        return [hours, min]
    }
}

extension Date {
    static func distance(from date1: Date, to date2: Date) -> TimeInterval {
        if #available(iOS 13.0, *) {
            return date1.distance(to: date2)
        } else {
            return date2.timeIntervalSince1970 - date1.timeIntervalSince1970
        }
    }
}
