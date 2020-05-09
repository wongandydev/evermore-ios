//
//  Budget.swift
//  EverMore
//
//  Created by Andy Wong on 5/5/20.
//  Copyright © 2020 Andy Wong. All rights reserved.
//

import UIKit

class BudgetManager {
    static func save(_ budget: Budget) {
        // save budget
        let jsonEncoder = JSONEncoder()
        
        if let savedData = try? jsonEncoder.encode(budget) {
            UserDefaults.standard.set(savedData, forKey: Constants.defaultBudget)
        } else {
            print("failed to save budget")
        }
    }
    
    static func get() -> Budget {
        if let savedBudget = UserDefaults.standard.object(forKey: Constants.defaultBudget) as? Data {
            let jsonDecoder = JSONDecoder()
            do {
                if let budget = try? jsonDecoder.decode(Budget.self, from: savedBudget) {
                    return budget
                } else {
                    return Budget(debt: nil, salary: nil, savingGoal: nil, goal: nil)
                }
            } catch {
                print("failed to get budget")
                return Budget(debt: nil, salary: nil, savingGoal: nil, goal: nil)
            }
        }
        
        return Budget(debt: nil, salary: nil, savingGoal: nil, goal: nil)
    }
}

struct Budget: Codable {
    var debt: Debt?
    var salary: Salary?
    var savingGoal: Saving?
    
    var goal: Goal?
    
//    enum BudgetCodingKeys: String, CodingKey {
//        case debt, salary, savingGoal, goal
//    }
    
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: BudgetCodingKeys.self)
//
//        debt = try values.decode(Debt.self, forKey: .debt)
//        salary = try values.decode(Salary.self, forKey: .salary)
//        savingGoal = try values.decode(Saving.self, forKey: .savingGoal)
//        goal = try values.decode(Goal.self, forKey: .goal)
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: BudgetCodingKeys.self)
//
//        try container.encode(debt, forKey: .debt)
//        try container.encode(salary, forKey: .salary)
//        try container.encode(savingGoal, forKey: .savingGoal)
//        try container.encode(goal, forKey: .goal)
//    }
    
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
    
//    enum DebtCodingKeys: String, CodingKey {
//        case amount, apr, dueDate
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: DebtCodingKeys.self)
//
//        amount = try values.decode(Double.self, forKey: .amount)
//        apr = try values.decode(Double.self, forKey: .apr)
//        dueDate = try values.decode(TimeInterval.self, forKey: .dueDate)
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: DebtCodingKeys.self)
//
//        try container.encode(amount, forKey: .amount)
//        try container.encode(apr, forKey: .apr)
//        try container.encode(dueDate, forKey: .dueDate)
//    }
}

struct Salary: Codable {
    var amount: Double
    var interval: Intervals
}

struct Saving: Codable {
    var amount: Double
    var interval: Intervals
}

struct Goal: Codable{
    var amount: Double
    var interval: Intervals
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

