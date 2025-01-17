//
//  ValuePickerViewController.swift
//  EverMore
//
//  Created by Andy Wong on 5/2/20.
//  Copyright © 2020 Andy Wong. All rights reserved.
//

import UIKit

class ValuePickerViewController: UIViewController {
    var budget: Budget = BudgetManager.get()
    var page: Int!
    var cellData: [OnboardingInfo]!
    
    private let bottomBackNextView = BottomBackNextView()
    private let amountTextField = UnderlineTextfield()
    private let frequencyPicker = UIPickerView()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        setupViews()
    }
    
    private func setupViews() {
        self.view.backgroundColor = .backgroundColor
        
        let categoryLabel = CategoryLabel()
        categoryLabel.text = cellData[page].categoryTitle
        
        self.view.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(100 * Constants.smallScreenTypeScale)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
        })
        
        
        let questionLabel = UILabel()
        questionLabel.text = cellData[page].questions?[0] ?? ""
        questionLabel.numberOfLines = 0
        
        self.view.addSubview(questionLabel)
        questionLabel.snp.makeConstraints({ make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(40 * Constants.smallScreenTypeScale)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
        })
        
        amountTextField.keyboardType = .decimalPad
        
        self.view.addSubview(amountTextField)
        amountTextField.snp.makeConstraints({ make in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.top.equalTo(questionLabel.snp.bottom).offset(40 * Constants.smallScreenTypeScale)
        })
        
        let howOftenLabel = UILabel()
        howOftenLabel.text = cellData[page].questions?[1] ?? ""
        
        self.view.addSubview(howOftenLabel)
        howOftenLabel.snp.makeConstraints({ make in
            make.top.equalTo(amountTextField.snp.bottom).offset(40 * Constants.smallScreenTypeScale)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
        })
        
        
        frequencyPicker.delegate = self
        frequencyPicker.dataSource = self
        
        self.view.addSubview(frequencyPicker)
        frequencyPicker.snp.makeConstraints({ make in
            make.top.equalTo(howOftenLabel.snp.bottom).offset(40 * Constants.smallScreenTypeScale)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
        })
        
        bottomBackNextView.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        
        self.view.addSubview(bottomBackNextView)
        bottomBackNextView.snp.makeConstraints({ make in
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(110)
        })

        bottomBackNextView.backButton.isEnabled = (page != 0)
        bottomBackNextView.nextButton.isEnabled = true
        bottomBackNextView.backButton.addTarget(self, action: #selector(backButtonTapped(_:)), for: .touchUpInside)
        bottomBackNextView.nextButton.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc func backButtonTapped(_ sender: UIButton) {
        if sender == bottomBackNextView.backButton {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func nextButtonTapped(_ sender: UIButton) {
        if sender == bottomBackNextView.nextButton {
            if let amountText = amountTextField.text {
                if let amount = Double(amountText) {
                    if cellData[page].categoryTitle == "Salary" {
                        self.budget.salary = Salary(amount: amount, interval: Intervals(freq[frequencyPicker.selectedRow(inComponent: 0)]))
                        BudgetManager.save(self.budget)
                        
                        let nextVC = ValuePickerViewController()
                        nextVC.page = page + 1
                        nextVC.cellData = cellData
                        
                        
                        self.navigationController?.pushViewController(nextVC, animated: true)
                    } else if cellData[page].categoryTitle == "Savings" {
                        self.budget.savingGoal = Saving(amount: amount, interval: Intervals(freq[frequencyPicker.selectedRow(inComponent: 0)]))
                        BudgetManager.save(self.budget)
                        UserDefaults.standard.set(true, forKey: Constants.defaultScreenerCompleted)
                        
                        let nextVC = TabBarController()
                        
                        self.navigationController?.pushViewController(nextVC, animated: true)
                    }
                } else {
                    showAlertMessage(title: "Amount Error", message: "The number you entered was not valid.")
                }
            } else {
                showAlertMessage(title: "Missing Information", message: "Please enter all information.")
            }
        }
    }
}


let freq = ["Daily", "Weekly", "Bi-weekly", "Monthly"]

extension ValuePickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    // MARK: - UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return freq.count
    }
    
    // MARK: - UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return freq[row]
    }
}
