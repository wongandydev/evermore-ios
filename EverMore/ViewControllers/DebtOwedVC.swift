//
//  DebtOwedVC.swift
//  EverMore
//
//  Created by Andy Wong on 5/5/20.
//  Copyright © 2020 Andy Wong. All rights reserved.
//

import UIKit


// This is the replacement VC for now as we slowly figure out how to add all the debt into one model for calculation in the future perhaps as a premium feature

class DebtOwedVC: UIViewController {
    var budget: Budget!
    var page: Int!
    var cellData: [OnboardingInfo]!
    
    private let bottomBackNextView = BottomBackNextView()
    private let amountTextField = UITextField()
    private let dueDateDatePicker = UIDatePicker()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        self.view.backgroundColor = .systemBackground
        
        let label = UILabel()
        label.text = "Debt"
        label.font = UIFont.systemFont(ofSize: 16)
        
        self.view.addSubview(label)
        label.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(Constants.topPadding + 20)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
        })
        
        let questionLabel = UILabel()
        questionLabel.text = "How much debt are you looking to pay off?"
        questionLabel.numberOfLines = 0
        
        self.view.addSubview(questionLabel)
        questionLabel.snp.makeConstraints({ make in
            make.top.equalTo(label.snp.bottom).offset(20)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
        })
        
        let itemizedStackView = UIStackView()
        itemizedStackView.axis = .vertical
        itemizedStackView.spacing = 10.0
        
        self.view.addSubview(itemizedStackView)
        itemizedStackView.snp.makeConstraints({ make in
            make.top.equalTo(questionLabel.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)

        })
        
        let item1StackView = UIStackView()
        item1StackView.axis = .horizontal
        
        itemizedStackView.addArrangedSubview(item1StackView)
        
        let amountTitleLabel = UILabel()
        amountTitleLabel.text = "Amount Due"
        amountTitleLabel.numberOfLines = 0
        amountTitleLabel.font = UIFont.systemFont(ofSize: 14)
        
        item1StackView.addArrangedSubview(amountTitleLabel)
        
        amountTextField.keyboardType = .decimalPad
        amountTextField.borderStyle = .line
        amountTextField.setDoneOnKeyboard()
        
        item1StackView.addArrangedSubview(amountTextField)
        amountTextField.snp.makeConstraints({ make in
            make.width.equalToSuperview().dividedBy(3)
        })
        
        let item3StackView = UIStackView()
        item3StackView.axis = .horizontal
        
        itemizedStackView.addArrangedSubview(item3StackView)
        
        let dueDateTitleLabel = UILabel()
        dueDateTitleLabel.text = "Due Date"
        dueDateTitleLabel.numberOfLines = 0
        dueDateTitleLabel.font = UIFont.systemFont(ofSize: 14)
        
        item3StackView.addArrangedSubview(dueDateTitleLabel)
        
        dueDateDatePicker.date = Date()
        dueDateDatePicker.datePickerMode = .date
        dueDateDatePicker.minimumDate =  Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.date(byAdding: .month, value: 1, to: Date())!))
        
        itemizedStackView.addArrangedSubview(dueDateDatePicker)
        dueDateDatePicker.snp.makeConstraints({ make in
            make.width.equalToSuperview()
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
        bottomBackNextView.nextButton.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
    }
    
    // MARK: - Button Funcs
    
    @objc func nextButtonTapped(_ sender: UIButton) {
        if sender == bottomBackNextView.nextButton {
            if let amountText = amountTextField.text, !amountText.isEmpty {
                let interval = dueDateDatePicker.date.timeIntervalSince1970
                
                if let amount = Double(amountText) {
                    self.budget.debt = Debt(amount: amount, apr: nil, dueDate: interval)
                    let nextVC = ValuePickerViewController()
                    nextVC.page = page + 1
                    nextVC.cellData = cellData
                    nextVC.budget = budget
                    
                    self.navigationController?.pushViewController(nextVC, animated: true)
                } else {
                    showAlertMessage(title: "Amount Error", message: "The number you entered was not valid.")
                }
                
            } else {
                showAlertMessage(title: "Missing Information", message: "Please enter all information.")
            }
        }
    }
}
