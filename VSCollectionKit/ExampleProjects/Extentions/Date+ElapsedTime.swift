//
//  Date+ElapsedTime.swift
//  MesengerShared
//
//  Created by Vinodh Govindaswamy on 18/02/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import Foundation

public extension Date {
    func elapsedTimeString(fromDate: Date = Date()) -> String {

        let calendar = Calendar.current
        let interval = calendar.dateComponents([.year,
                                                .month,
                                                .weekOfMonth,
                                                .day,
                                                .hour,
                                                .minute],
                                               from: self,
                                               to: fromDate)

        if let year = interval.year, year > 0 {
            return "\(year) year\(year == 1 ? "": "s") ago"
        } else if let month = interval.month, month > 0 {
            return "\(month) month\(month == 1 ? "":"s") ago"
        } else if let day = interval.day, day > 0 {
            return "\(day) day\(day == 1 ? "":"s") ago"
        } else if let hour = interval.hour, hour > 0 {
            return "\(hour) hour\(hour == 1 ? "":"s") ago"
        } else if let minutes = interval.minute, minutes > 0 {
            return "\(minutes) minute\(minutes == 1 ? "":"s") ago"
        }
        return "Just now"
    }
}
