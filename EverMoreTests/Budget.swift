//
//  Budget.swift
//  EverMoreTests
//
//  Created by Andy Wong on 5/8/20.
//  Copyright © 2020 Andy Wong. All rights reserved.
//

import Foundation
import XCTest
@testable import EverMore

class BudgetTest: XCTestCase {

    func testAddDebt() {
        var budget = Budget()
        budget.debt = Debt(amount: 123.0, apr: nil, dueDate: Date().timeIntervalSince1970)
        
        XCTAssertTrue(budget.debt != nil)
    }
    
    func testAddSalary() {
        var budget = Budget()
        budget.salary = Salary(amount: 250, interval: .daily)
        
        XCTAssertTrue(budget.salary != nil)
    }
    
    func testAddSavingGoal() {
        var budget = Budget()
        budget.savingGoal = Saving(amount: 100, interval: .daily)
        
        XCTAssertTrue(budget.savingGoal != nil)
    }
    
    
    func testSetGoalSameInterval() {
        // Without Debt
        
        // Both Daily
        var budget = Budget()
        budget.salary = Salary(amount: 250, interval: .daily)
        budget.savingGoal = Saving(amount: 100, interval: .daily)

        budget.setGoal()

        XCTAssertTrue(budget.goal?.amount == 150)
        
        // Test Doubles
        budget.salary = Salary(amount: 284.34, interval: .daily)
        budget.savingGoal = Saving(amount: 100, interval: .daily)
        
        budget.setGoal()
        XCTAssertTrue(budget.goal?.amount == 184.34)
        
        // Both Weekly
        budget.salary = Salary(amount: 1000, interval: .weekly)
        budget.savingGoal = Saving(amount: 500, interval: .weekly)
        
        budget.setGoal()
        XCTAssertTrue(budget.goal?.amount == 500)
        
        // Both Bi-Weekly
        budget.salary = Salary(amount: 1000, interval: .bi_weekly)
        budget.savingGoal = Saving(amount: 500, interval: .bi_weekly)
        
        budget.setGoal()
        XCTAssertTrue(budget.goal?.amount == 500)
        
        // Both Monthly
        budget.salary = Salary(amount: 1000, interval: .monthly)
        budget.savingGoal = Saving(amount: 500, interval: .monthly)
        
        budget.setGoal()
        XCTAssertTrue(budget.goal?.amount == 500)
    
        // With Debt
        
        // too much debt
        
        // The first of the month, five months later
        let dueDate = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.date(byAdding: .month, value: 5, to: Date())!))
        let dueDateInterval = dueDate!.timeIntervalSince1970
        budget.debt = Debt(amount: 5000, apr: nil, dueDate: dueDateInterval)
        budget.salary = Salary(amount: 1000, interval: .monthly)
        budget.savingGoal = Saving(amount: 500, interval: .monthly)
            
        budget.setGoal()
        XCTAssertTrue(budget.goal?.amount == 500) // if too much debt, we dispaly salary and savings goal
        
        // Debt and salary + saving goal is exactly right
        budget.debt = Debt(amount: 5000, apr: nil, dueDate: dueDateInterval)
        budget.salary = Salary(amount: 1500, interval: .monthly)
        budget.savingGoal = Saving(amount: 500, interval: .monthly)
            
        budget.setGoal()
        XCTAssertTrue(budget.goal?.amount == 1000)
        
        // Salary is higher than debt and savings goal
        budget.debt = Debt(amount: 5000, apr: nil, dueDate: dueDateInterval)
        budget.salary = Salary(amount: 1900, interval: .monthly)
        budget.savingGoal = Saving(amount: 500, interval: .monthly)
            
        budget.setGoal()
        XCTAssertTrue(budget.goal?.amount == 400)
    }
    
    func testSetGoalDifferentInterval() {
        // without debt
        var budget = Budget()
        
        // Salary: Daily Saving: Weekly
        budget.salary = Salary(amount: 1000, interval: .daily)
        budget.savingGoal = Saving(amount: 500, interval: .weekly)
        
        budget.setGoal()
        XCTAssertTrue(budget.goal?.amount == 6500)
        
        // Salary: Daily Saving: Bi-Weekly
        budget.salary = Salary(amount: 1000, interval: .daily)
        budget.savingGoal = Saving(amount: 6000, interval: .bi_weekly)
        
        budget.setGoal()
        XCTAssertTrue(budget.goal?.amount == 8000)
        
        // Salary: Daily Saving: Monthly
        budget.salary = Salary(amount: 1000, interval: .daily)
        budget.savingGoal = Saving(amount: 20000, interval: .monthly)
        
        budget.setGoal()
        XCTAssertTrue(budget.goal?.amount == 8000)
        
        // Salary: Weekly Saving: Daily
        budget.salary = Salary(amount: 1000, interval: .weekly)
        budget.savingGoal = Saving(amount: 60, interval: .daily)
        
        budget.setGoal()
        XCTAssertTrue(budget.goal?.amount == 82.86)
        
        // Salary: Weekly Saving: Bi-Weekly
        budget.salary = Salary(amount: 1000, interval: .weekly)
        budget.savingGoal = Saving(amount: 1000, interval: .bi_weekly)
        
        budget.setGoal()
        XCTAssertTrue(budget.goal?.amount == 1000)
        
        // Salary: Weekly Saving: Monthly
        
        // Salary: Bi-Weekly Saving: Daily
        
        // Salary: Bi-Weekly Saving: Weekly
        
        // Salary: Bi-Weekly Saving: Monthly
        
        // Salary: Monthly Saving: Daily
        
        // Salary: Monthly Saving: Weekly
        
        // Salary: Monthly Saving: Bi-Weekly
        
        // With Debt
    }
    
    func testSavingGoalGreaterThanSalary() {
        var budget = Budget()
        
        budget.salary = Salary(amount: 1000, interval: .weekly)
        budget.savingGoal = Saving(amount: 200, interval: .daily)
        
        budget.setGoal()
        XCTAssertTrue(budget.goal?.amount == 142.86)
    }

}
