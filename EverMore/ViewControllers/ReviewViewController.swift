//
//  ReviewViewController.swift
//  EverMore
//
//  Created by Andy Wong on 5/7/20.
//  Copyright © 2020 Andy Wong. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {
    var budget: Budget!
    
    private let bottomBackNextView = BottomBackNextView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        budget.setGoal()
        
        setupViews()
    }
    
    private func setupViews() {
        self.view.backgroundColor = .systemBackground
        
        let categoryLabel = UILabel()
        categoryLabel.text = "Review"
        categoryLabel.font = UIFont.systemFont(ofSize: 20)
        
        self.view.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(Constants.topPadding + 20)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
        })
        
        let vStack = UIStackView()
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
        salaryStack.addArrangedSubview(salaryText)
        
        let salaryLabel = UILabel()
        salaryLabel.numberOfLines = 0
        
        if let salary = budget.salary {
            salaryLabel.text = "\(salary.amount)/\(salary.interval.rawValue)"
        } else {
            salaryLabel.text = "No Salary"
        }
        
        salaryStack.addArrangedSubview(salaryLabel)
        
        let savingsStack = UIStackView()
        savingsStack.axis = .horizontal
        vStack.addArrangedSubview(savingsStack)
        
        let savingsText = UILabel()
        savingsText.text = "Savings: "
        savingsText.numberOfLines = 0
        savingsStack.addArrangedSubview(savingsText)
        
        let savingsLabel = UILabel()
        savingsLabel.numberOfLines = 0
        
        if let savings = budget.savingGoal {
            savingsLabel.text = "\(savings.amount)/\(savings.interval.rawValue)"
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
            goalStack.addArrangedSubview(goalText)
            
            let goalLabel = UILabel()
            goalLabel.text = "\(goal.interval) budget of: \(goal.amount.rounded())"
            goalStack.addArrangedSubview(goalLabel)
        }
        
        
        bottomBackNextView.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        
        self.view.addSubview(bottomBackNextView)
        bottomBackNextView.snp.makeConstraints({ make in
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(110)
        })

        bottomBackNextView.backButton.isEnabled = true
        bottomBackNextView.nextButton.isEnabled = true
        bottomBackNextView.backButton.addTarget(self, action: #selector(backButtonTapped(_:)), for: .touchUpInside)
        bottomBackNextView.nextButton.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
    }
    
    // MARK: - Button Funcs
    
    @objc func backButtonTapped(_ sender: UIButton) {
        if sender == bottomBackNextView.backButton {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func nextButtonTapped(_ sender: UIButton) {
        if sender == bottomBackNextView.nextButton {
            showAlertMessage(title: "Coming Soon", message: "Soon after you finish these questions you can start adding information like your what you bought to make sure you are on budget")
        }
    }
}

