//
//  HomeViewController.swift
//  EverMore
//
//  Created by Andy Wong on 5/9/20.
//  Copyright © 2020 Andy Wong. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    private var budget = BudgetManager.get()
    private let budgetLabel = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if budget.goal == nil {
            budget.setGoal()
        }
        
        setupViews()
    }
    
    private func setupViews() {
        self.view.backgroundColor = .systemBackground
        
        budgetLabel.text = String(format: "$ %.2f", Double(budget.currentBudget ?? 0))
        budgetLabel.textAlignment = .center
        budgetLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        
        
        self.view.addSubview(budgetLabel)
        budgetLabel.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(130 * Constants.smallScreenTypeScale)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
        })
        
        let intervalLabel = UILabel()
        intervalLabel.text = "to use \(budget.goal?.interval.rawValue ?? "someday")"
        intervalLabel.textAlignment = .center
        intervalLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        
        
        self.view.addSubview(intervalLabel)
        intervalLabel.snp.makeConstraints({ make in
            make.top.equalTo(budgetLabel.snp.bottom).offset(5)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
        })
        
        
        let iMadeMoneyContainerView = UIView()
        
        self.view.addSubview(iMadeMoneyContainerView)
        iMadeMoneyContainerView.snp.makeConstraints({ make in
            make.top.equalTo(self.view.snp.centerY)
            make.width.equalToSuperview().dividedBy(2).offset(-10)
            make.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview()
        })
        
        let iMadeMoneyImageView = UIImageView()
        iMadeMoneyImageView.image = UIImage(named: "plus")
        
        iMadeMoneyContainerView.addSubview(iMadeMoneyImageView)
        iMadeMoneyImageView.snp.makeConstraints({ make in
            make.top.equalToSuperview()
            make.width.height.equalTo(80)
            make.centerX.equalToSuperview()
        })
        
        let iMadeMoneyText = UILabel()
        iMadeMoneyText.text = "I made more money!"
        iMadeMoneyText.numberOfLines = 0
        iMadeMoneyText.textAlignment = .center
        
        iMadeMoneyContainerView.addSubview(iMadeMoneyText)
        iMadeMoneyText.snp.makeConstraints({ make in
            make.top.equalTo(iMadeMoneyImageView.snp.bottom)
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
        })
        
        let iMadeMoneyButton = UIButton()
        iMadeMoneyButton.addTarget(self, action: #selector(iMadeMoneyButtonTapped), for: .touchUpInside)
        
        iMadeMoneyContainerView.addSubview(iMadeMoneyButton)
        iMadeMoneyButton.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
        
        let iInvestedInMyselfContainerView = UIView()
        
        self.view.addSubview(iInvestedInMyselfContainerView)
        iInvestedInMyselfContainerView.snp.makeConstraints({ make in
            make.top.equalTo(self.view.snp.centerY)
            make.width.equalToSuperview().dividedBy(2).offset(-10)
            make.right.equalToSuperview().inset(10)
            make.bottom.equalToSuperview()
        })
        
        
        let iInvestedInMyselfImageView = UIImageView()
        iInvestedInMyselfImageView.image = UIImage(named: "minus")
        
        iInvestedInMyselfContainerView.addSubview(iInvestedInMyselfImageView)
        iInvestedInMyselfImageView.snp.makeConstraints({ make in
            make.top.equalToSuperview()
            make.width.height.equalTo(80)
            make.centerX.equalToSuperview()
        })
        
        let iInvestedInMyselfText = UILabel()
        iInvestedInMyselfText.text = "I invested in myself!"
        iInvestedInMyselfText.numberOfLines = 0
        iInvestedInMyselfText.textAlignment = .center
        
        iInvestedInMyselfContainerView.addSubview(iInvestedInMyselfText)
        iInvestedInMyselfText.snp.makeConstraints({ make in
            make.top.equalTo(iInvestedInMyselfImageView.snp.bottom)
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
        })
        
        let iInvestedInMyselfButton = UIButton()
        iInvestedInMyselfButton.addTarget(self, action: #selector(iInvestedInMyselfButtonTapped), for: .touchUpInside)
        
        iInvestedInMyselfContainerView.addSubview(iInvestedInMyselfButton)
        iInvestedInMyselfButton.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
    }
    
    @objc private func iMadeMoneyButtonTapped(_ sender: UIButton) {
        let editVC = EditCurrentBudgetVC()
        editVC.addMoney = true
        editVC.delegate = self
        
        self.present(editVC, animated: true, completion: nil)
    }
    
    @objc private func iInvestedInMyselfButtonTapped(_ sender: UIButton) {
        let editVC = EditCurrentBudgetVC()
        editVC.addMoney = false
        editVC.delegate = self
        
        self.present(editVC, animated: true, completion: nil)
    }
}

extension HomeViewController: EditBudgetDelegate {
    func getNewBudget() {
        budget = BudgetManager.get()
        budgetLabel.text = String(format: "$ %.2f", Double(budget.currentBudget ?? 0))
    }
}
