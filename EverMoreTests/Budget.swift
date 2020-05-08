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
    
    
    func testSetGoal() {
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
        
        // Salary: Daily Saving: Weekly
        budget.salary = Salary(amount: 1000, interval: .daily)
        budget.savingGoal = Saving(amount: 500, interval: .weekly)
        
        budget.setGoal()
        XCTAssertTrue(budget.goal?.amount == 6500)
        
        // Salary: Daily Saving: Bi-Weekly
        
        // Salary: Daily Saving: Monthly
        
        // Salary: Weekly Saving: Daily
        
        // Salary: Weekly Saving: Bi-Weekly
        
        // Salary: Weekly Saving: Monthly
        
        // Salary: Bi-Weekly Saving: Daily
        
        // Salary: Bi-Weekly Saving: Weekly
        
        // Salary: Bi-Weekly Saving: Monthly
        
        // Salary: Monthly Saving: Daily
        
        // Salary: Monthly Saving: Weekly
        
        // Salary: Monthly Saving: Bi-Weekly
        
        
        // With Debt
    }

}
