//
//  Budget.swift
//  EverMore
//
//  Created by Andy Wong on 5/5/20.
//  Copyright © 2020 Andy Wong. All rights reserved.
//

import UIKit

struct Budget {
    var debt: [Debt]?
    var salary: Int?
    var savingGoal: Int?
    
    var goal: Goal?
}

struct Debt {
    var amount: Int?
    var apr: Double?
    var dueDate: TimeInterval?
}

class Goal {
    var amount: Int
    var interval: Intervals
    
    init(amount: Int, interval: Intervals) {
        self.amount = amount
        self.interval = interval
    }
    
    func convertToDay() {
        if interval == .week {
            amount = amount/7
            interval = .day
        } else if interval == .month {
            amount = amount/30
            interval = .day
        } else {
            // do nothing since that means we are converting day to day
        }
    }
    
    func convertToWeek() {
        if interval == .month {
            amount = amount/4
            interval = .week
        } else if interval == .day {
            amount = amount*7
            interval = .week
        } else {
            // do nothing since that means we are converting week to week
        }
    }
    
    func convertToMonth() {
        if interval == .week {
            amount = amount*4
            interval = .month
        } else if interval == .day {
            amount = amount*30
            interval = .month
        } else {
            // do nothing since that means we are converting month to month
        }
    }
}

enum Intervals: String {
    typealias RawValue = String
    
    case day, week, month
}
