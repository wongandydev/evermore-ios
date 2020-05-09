//
//  Budget.swift
//  EverMore
//
//  Created by Andy Wong on 5/5/20.
//  Copyright © 2020 Andy Wong. All rights reserved.
//

import UIKit

struct Budget: Codable {
    var debt: Debt?
    var salary: Salary?
    var savingGoal: Saving?
    
    var goal: Goal?
    
    private func calculateGoalWithSameInterval(salary: Salary, saving: Saving) -> Goal {
        let budget = salary.amount - saving.amount
        if budget > 0 {
            return Goal(amount: budget, interval: saving.interval)
        } else {
            //if savings amount is larger than salary, set amount to the salary based on interval
            return Goal(amount: salary.amount, interval: saving.interval)
        }
    }
    
    private func calculateGoalWithDifferentIntervals(salary: Salary, saving: Saving) -> Goal {
        switch (salary.interval, saving.interval) {
            case (.weekly, .daily):
                let dailySalary = salary.amount / 7
                let dailyBudget = dailySalary - saving.amount
                
                if dailyBudget > 0 {
                    return Goal(amount: dailyBudget, interval: saving.interval)
                } else {
                    //if savings amount is larger than salary, set amount to the salary based on interval
                    return Goal(amount: dailySalary, interval: saving.interval)
                }
            case (.weekly, .bi_weekly):
                let biweeklySalary = (2 * salary.amount)
                let biweeklyBudget = biweeklySalary - saving.amount
                if biweeklyBudget > 0 {
                    return  Goal(amount: biweeklyBudget, interval: saving.interval)
                } else {
                    //if savings amount is larger than salary, set amount to the salary based on interval
                    return Goal(amount: biweeklySalary, interval: saving.interval)
                }
            case (.weekly, .monthly):
                let monthlySalary = 4 * salary.amount
                let monthlyBudget = monthlySalary - saving.amount
                if monthlyBudget > 0 {
                    return Goal(amount: monthlyBudget, interval: saving.interval)
                } else {
                    //if savings amount is larger than salary, set amount to the salary based on interval
                    return Goal(amount: monthlySalary, interval: saving.interval)
                }
            case (.daily, .weekly):
                let weeklySalary = salary.amount * 7
                let weeklyBudget = weeklySalary - saving.amount
                if weeklyBudget > 0 {
                    return Goal(amount: weeklyBudget, interval: saving.interval)
                } else {
                    //if savings amount is larger than salary, set amount to the salary based on interval
                    return Goal(amount: weeklySalary, interval: saving.interval)
                }
            case (.daily, .bi_weekly):
                let biweeklySalary = (salary.amount * 7) * 2
                let biweeklyBudget = biweeklySalary - saving.amount
                if biweeklyBudget > 0 {
                    return Goal(amount: biweeklyBudget, interval: saving.interval)
                } else {
                    //if savings amount is larger than salary, set amount to the salary based on interval
                    return Goal(amount: biweeklySalary, interval: saving.interval)
                }
            case (.daily, .monthly):
                let monthlySalary = (salary.amount * 7) * 4
                let monthlyBudget = monthlySalary - saving.amount
                if monthlyBudget > 0 {
                    return Goal(amount: monthlyBudget, interval: saving.interval)
                } else {
                    //if savings amount is larger than salary, set amount to the salary based on interval
                    return Goal(amount: monthlySalary, interval: saving.interval)
                }
            case (.monthly, .daily):
                let dailySalary = (salary.amount / 4) / 7
                let dailyBudget = dailySalary - saving.amount
                if dailyBudget > 0 {
                    return Goal(amount: dailyBudget, interval: saving.interval)
                } else {
                    //if savings amount is larger than salary, set amount to the salary based on interval
                    return Goal(amount: dailySalary, interval: saving.interval)
                }
            case (.monthly, .weekly):
                let weeklySalary = salary.amount/4
                let weeklyBudget = weeklySalary - saving.amount
                if weeklyBudget > 0 {
                    return Goal(amount: weeklyBudget, interval: saving.interval)
                } else {
                    //if savings amount is larger than salary, set amount to the salary based on interval
                    return Goal(amount: weeklySalary, interval: saving.interval)
                }
            case (.monthly, .bi_weekly):
                let biweeklySalary = (salary.amount / 4) * 2
                let biweeklyBudget = biweeklySalary - saving.amount
                if biweeklyBudget > 0 {
                    return Goal(amount: biweeklyBudget, interval: saving.interval)
                } else {
                    //if savings amount is larger than salary, set amount to the salary based on interval
                    return Goal(amount: biweeklySalary, interval: saving.interval)
                }
            case (.bi_weekly, .daily):
                let dailySalary = (salary.amount / 2) / 7
                let dailyBudget = dailySalary - saving.amount
                if dailyBudget > 0 {
                    return Goal(amount: dailyBudget, interval: saving.interval)
                } else {
                    //if savings amount is larger than salary, set amount to the salary based on interval
                    return Goal(amount: dailySalary, interval: saving.interval)
                }
            case (.bi_weekly, .weekly):
                let weeklySalary = salary.amount/2
                let weeklyBudget = weeklySalary - saving.amount
                if weeklyBudget > 0 {
                    return Goal(amount: weeklyBudget, interval: saving.interval)
                } else {
                    //if savings amount is larger than salary, set amount to the salary based on interval
                    return Goal(amount: weeklySalary, interval: saving.interval)
                }
            case (.bi_weekly, .monthly):
                let monthlySalary = salary.amount * 2
                let monthlyBudget = monthlySalary - saving.amount
                if monthlyBudget > 0 {
                    return Goal(amount: monthlyBudget, interval: saving.interval)
                } else {
                    //if savings amount is larger than salary, set amount to the salary based on interval
                    return Goal(amount: monthlySalary, interval: saving.interval)
                }
            default:
                return calculateGoalWithSameInterval(salary: salary, saving: saving)
        }
    }
    
    mutating func setGoal() {
        if let debt = self.debt {
            let dueDate = Date(timeIntervalSince1970: debt.dueDate)
            let toDate = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Date()))!
            let monthsRemaining = abs(toDate.months(from: dueDate))
            let debtAmount = debt.amount
            let debtDuePerMonth = debtAmount/Double(monthsRemaining)
            if let salary = salary, let saving = savingGoal {
                let result = calculateGoalWithDebt(debt: debtDuePerMonth, salary: salary, saving: saving)
                if result.1 == nil {
                    goal = result.0
                } else {
                    self.debt = nil
                    goal = result.0
                }
            }
        } else {
            if let salary = salary, let saving = savingGoal {
                let salaryInterval = salary.interval
                let savingInterval = saving.interval
                
                if salaryInterval == savingInterval {
                    goal = calculateGoalWithSameInterval(salary: salary, saving: saving)
                } else {
                    goal = calculateGoalWithDifferentIntervals(salary: salary, saving: saving)
                }
                
            }
        }
    }
    
    func calculateGoalWithDebt(debt: Double, salary: Salary, saving: Saving) -> (Goal, String?) {
        let goalBasedOnSalaryAndSaving = calculateGoalWithDifferentIntervals(salary: salary, saving: saving)
        switch goalBasedOnSalaryAndSaving.interval {
            case .daily:
                let dailyDebtPayOff = (debt/4) / 7
                if goalBasedOnSalaryAndSaving.amount > dailyDebtPayOff {
                    return (Goal(amount: goalBasedOnSalaryAndSaving.amount - dailyDebtPayOff, interval: goalBasedOnSalaryAndSaving.interval), nil)
                } else {
                    return (goalBasedOnSalaryAndSaving, "debt too high")
                }
            case .weekly:
                let weeklyDebtPayOff = debt/4
                if goalBasedOnSalaryAndSaving.amount > weeklyDebtPayOff {
                    return (Goal(amount: goalBasedOnSalaryAndSaving.amount - weeklyDebtPayOff, interval: goalBasedOnSalaryAndSaving.interval), nil)
                } else {
                    return (goalBasedOnSalaryAndSaving, "debt too high")
                }
            case .bi_weekly:
                let biweeklyDebtPayOff = (debt/4) * 2
                if goalBasedOnSalaryAndSaving.amount > biweeklyDebtPayOff {
                    return (Goal(amount: goalBasedOnSalaryAndSaving.amount - biweeklyDebtPayOff, interval: goalBasedOnSalaryAndSaving.interval), nil)
                } else {
                    return (goalBasedOnSalaryAndSaving, "debt too high")
                }
            case .monthly:
                let monthlyDebtPayOff = debt
                if goalBasedOnSalaryAndSaving.amount > monthlyDebtPayOff {
                    return (Goal(amount: goalBasedOnSalaryAndSaving.amount - monthlyDebtPayOff, interval: goalBasedOnSalaryAndSaving.interval), nil)
                } else {
                    return (goalBasedOnSalaryAndSaving, "debt too high")
                }
        }
    }
}

struct Debt: Codable {
    var amount: Double
    var apr: Double?
    var dueDate: TimeInterval
}

class Salary: Igg {
    override init(amount: Double, interval: Intervals) {
        super.init(amount: amount, interval: interval)
        self.amount = amount
        self.interval = interval
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}



class Saving: Igg {
    override init(amount: Double, interval: Intervals) {
        super.init(amount: amount, interval: interval)
        self.amount = amount
        self.interval = interval
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

class Goal: Igg {
    override init(amount: Double, interval: Intervals) {
        super.init(amount: amount, interval: interval)
        self.amount = (amount * 100).rounded()/100
        self.interval = interval
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

enum Intervals: String, Codable {
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

class Igg: Codable {
    var amount: Double
    var interval: Intervals
    
    init(amount: Double, interval: Intervals) {
        self.amount = amount
        self.interval = interval
    }
    
    enum IggCodingKeys: String, CodingKey {
        case amount, interval
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


