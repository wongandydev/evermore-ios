//
//  ReviewViewController.swift
//  EverMore
//
//  Created by Andy Wong on 5/7/20.
//  Copyright © 2020 Andy Wong. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {
    var budget: Budget = BudgetManager.get()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if budget.goal == nil {
            budget.setGoal()
        }
        
        setupViews()
    }
    
    private func setupViews() {
        self.view.backgroundColor = .systemBackground
        
        let categoryLabel = UILabel()
        categoryLabel.text = "Review"
        categoryLabel.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        
        self.view.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(Constants.topPadding + Constants.navigationBarHeight)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
        })
        
        let vStack = UIStackView()
        vStack.spacing = 20
        vStack.axis = .vertical
        
        self.view.addSubview(vStack)
        vStack.snp.makeConstraints({ make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(30 * Constants.smallScreenTypeScale)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
        })
        
        let debtStack = UIStackView()
        debtStack.axis = .horizontal
        vStack.addArrangedSubview(debtStack)
        
        let debtText = UILabel()
        debtText.text = "Debt:"
        debtText.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        debtStack.addArrangedSubview(debtText)
        
        let debtLabel = UILabel()
        debtLabel.numberOfLines = 0
        
        if let debt = budget.debt {
            debtLabel.text = "\(String(describing: debt.amount)) Due on \(Date(timeIntervalSince1970: debt.dueDate ?? TimeInterval()))"
        } else {
            debtLabel.text = "No Debt! YAY!"
        }
        debtStack.addArrangedSubview(debtLabel)
        
        
        let salaryStack = UIStackView()
        salaryStack.axis = .horizontal
        vStack.addArrangedSubview(salaryStack)
        
        let salaryText = UILabel()
        salaryText.text = "Salary:"
        salaryText.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        salaryStack.addArrangedSubview(salaryText)
        
        let salaryLabel = UILabel()
        salaryLabel.numberOfLines = 0
        
        if let salary = budget.salary {
            salaryLabel.text = "$\(salary.amount)/\(salary.interval.rawValue)"
        } else {
            salaryLabel.text = "No Salary"
        }
        
        salaryStack.addArrangedSubview(salaryLabel)
        
        let savingsStack = UIStackView()
        savingsStack.axis = .horizontal
        vStack.addArrangedSubview(savingsStack)
        
        let savingsText = UILabel()
        savingsText.text = "Savings: "
        savingsText.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        savingsText.numberOfLines = 0
        savingsStack.addArrangedSubview(savingsText)
        
        let savingsLabel = UILabel()
        savingsLabel.numberOfLines = 0
        
        if let savings = budget.savingGoal {
            savingsLabel.text = "$\(savings.amount)/\(savings.interval.rawValue)"
        } else {
            savingsLabel.text = "No Savings set."
        }
        
        savingsStack.addArrangedSubview(savingsLabel)
        
        if let goal = budget.goal {
            let goalStack = UIStackView()
            goalStack.axis = .horizontal
            vStack.addArrangedSubview(goalStack)
            
            let goalText = UILabel()
            goalText.text = "Goal: "
            goalText.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
            goalStack.addArrangedSubview(goalText)
            
            let goalLabel = UILabel()
            goalLabel.text = "\(goal.interval.rawValue.capitalizingFirstLetter()) budget of: $\(goal.amount)"
            goalLabel.numberOfLines = 0
            goalStack.addArrangedSubview(goalLabel)
        }
    }
}

