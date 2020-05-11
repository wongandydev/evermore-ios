//
//  EditCurrentBudgetVC.swift
//  EverMore
//
//  Created by Andy Wong on 5/11/20.
//  Copyright © 2020 Andy Wong. All rights reserved.
//

import UIKit

protocol EditBudgetDelegate {
    func getNewBudget()
}

class EditCurrentBudgetVC: UIViewController {
    private var budget = BudgetManager.get()
    
    private let enterTextField = UITextField()
    private let bottomBackNextView = BottomBackNextView()
    
    var delegate: EditBudgetDelegate!
    
    var addMoney: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        self.view.backgroundColor = .systemBackground
        
        let enterLabel = UILabel()
        enterLabel.text = "Enter amount: "
        enterLabel.textAlignment = .center
        
        self.view.addSubview(enterLabel)
        enterLabel.snp.makeConstraints({ make in
            make.bottom.equalTo(self.view.snp.centerY).offset(-80)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
        })
        
        enterTextField.delegate = self
        enterTextField.keyboardType = .numberPad
        enterTextField.borderStyle = .line
        enterTextField.setDoneOnKeyboard()
        
        self.view.addSubview(enterTextField)
        enterTextField.snp.makeConstraints({ make in
            make.top.equalTo(enterLabel.snp.bottom).offset(20)
            make.width.equalToSuperview().dividedBy(2)
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

        bottomBackNextView.backButton.isEnabled = true
        bottomBackNextView.backButton.addTarget(self, action: #selector(backButtonTapped(_:)), for: .touchUpInside)
        bottomBackNextView.nextButton.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc private func backButtonTapped(_ sender: UIButton) {
        if sender == bottomBackNextView.backButton {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc private func nextButtonTapped(_ sender: UIButton) {
        if sender == bottomBackNextView.nextButton {
            if addMoney {
                if let enterTextfieldText = enterTextField.text, let additionalMoney = Double(enterTextfieldText) {
                    budget.currentBudget? += additionalMoney
                    BudgetManager.save(budget)
                    delegate.getNewBudget()
                    self.dismiss(animated: true, completion: nil)
                }
            } else {
                if let enterTextfieldText = enterTextField.text, let additionalMoney = Double(enterTextfieldText) {
                    budget.currentBudget? -= additionalMoney
                    BudgetManager.save(budget)
                    delegate.getNewBudget()
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
}

extension EditCurrentBudgetVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        bottomBackNextView.nextButton.isEnabled = !textField.text!.isEmpty
    }
}
