//
//  Budget.swift
//  EverMore
//
//  Created by Andy Wong on 5/5/20.
//  Copyright © 2020 Andy Wong. All rights reserved.
//

import UIKit

struct Budget {
    var debt: Debt?
    var salary: Salary?
    var savingGoal: Saving?
    
    var goal: Goal?
    
    
}

struct Debt {
    var amount: Double?
    var apr: Double?
    var dueDate: TimeInterval?
}

class Salary: Igg {
//    var amount: Double
//    var interval: Intervals
    
    override init(amount: Double, interval: Intervals) {
        super.init(amount: amount, interval: interval)
        self.amount = amount
        self.interval = interval
    }
}



class Saving: Igg {
//    var amount: Double
//    var interval: Intervals
    
    override init(amount: Double, interval: Intervals) {
        super.init(amount: amount, interval: interval)
        self.amount = amount
        self.interval = interval
    }
}

class Goal: Igg {
//    var amount: Int
//    var interval: Intervals
    
    override init(amount: Double, interval: Intervals) {
        super.init(amount: amount, interval: interval)
        self.amount = amount
        self.interval = interval
    }
}

enum Intervals: String {
    typealias RawValue = String
    
    case daily, weekly, bi_weekly, monthly
    
    init(_ string: String) {
        switch string {
        case "day", "daily", "Daily" :
            self = .daily
        case "week", "weekly", "Weekly" :
            self = .weekly
        case "bi-weekly", "Bi-weekly":
            self = .bi_weekly
        case "month", "monthly", "Monthly":
            self = .monthly
        default:
            self = .daily
        }
    }
}

protocol IntervalDelegate {
    func convertToDay()
    func convertToWeek()
    func convertToMonth()
}

class Igg {
    var amount: Double
    var interval: Intervals
    
    init(amount: Double, interval: Intervals) {
        self.amount = amount
        self.interval = interval
    }
    
    func convertToDay() {
        if interval == .weekly {
            amount = amount/7
            interval = .daily
        } else if interval == .monthly {
            amount = amount/30
            interval = .daily
        } else {
            // do nothing since that means we are converting day to day
        }
    }
    
    func convertToWeek() {
        if interval == .monthly {
            amount = amount/4
            interval = .weekly
        } else if interval == .daily {
            amount = amount*7
            interval = .weekly
        } else {
            // do nothing since that means we are converting week to week
        }
    }
    
    func convertToMonth() {
        if interval == .weekly {
            amount = amount*4
            interval = .monthly
        } else if interval == .daily {
            amount = amount*30
            interval = .monthly
        } else {
            // do nothing since that means we are converting month to month
        }
    }
}
