//
//  MultipleSelectionListViewController.swift
//  EverMore
//
//  Created by Andy Wong on 5/3/20.
//  Copyright © 2020 Andy Wong. All rights reserved.
//

import UIKit

class MultipleSelectionListViewController: UIViewController {
    
    var page: Int!
    var cellData: [OnboardingInfo]!
    
    // [.creditCard: [amount_owed: 100, apr: 25, dueDate: 123498723]]
    var selectionData = [SelectionType: [String: Int]]()
    
    private let bottomBackNextView = BottomBackNextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
                
        let scrollView = UIScrollView()
        scrollView.bounces = true
        
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
        
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .vertical
        
        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(Constants.topPadding)
            make.right.left.equalTo(view)
            make.bottom.equalToSuperview().inset(140)
        })
        
        for key in selectionData.keys {
            let view = UIView()
            
            stackView.addArrangedSubview(view)
            
            let debtTypeLabel = UILabel()
            debtTypeLabel.numberOfLines = 0
            debtTypeLabel.text = key.rawValue
            debtTypeLabel.font = UIFont.systemFont(ofSize: 16)
            
            view.addSubview(debtTypeLabel)
            debtTypeLabel.snp.makeConstraints({ make in
                make.top.equalToSuperview().offset(20)
                make.centerX.equalToSuperview()
                make.width.equalToSuperview().multipliedBy(0.8)
            })
            
            let descriptionLabel = UILabel()
            descriptionLabel.numberOfLines = 0
            descriptionLabel.text = "If you have a promo 0% APR please enter the actual APR amount and when it will be effective for accurate budgetting,"
            descriptionLabel.font = UIFont.systemFont(ofSize: 12)
            
            view.addSubview(descriptionLabel)
            descriptionLabel.snp.makeConstraints({ make in
                make.top.equalTo(debtTypeLabel.snp.bottom).offset(10)
                make.centerX.equalToSuperview()
                make.width.equalToSuperview().multipliedBy(0.8)
                
                
            })
            
            let itemizedStackView = UIStackView()
            itemizedStackView.axis = .vertical
            itemizedStackView.spacing = 10.0
            
            view.addSubview(itemizedStackView)
            itemizedStackView.snp.makeConstraints({ make in
                make.top.equalTo(descriptionLabel.snp.bottom).offset(25)
                make.centerX.equalToSuperview()
                make.width.equalToSuperview().multipliedBy(0.8)
                make.bottom.equalToSuperview()
            })
            
            let titles = ["Amount Owed", "APR", "Due Date", "w","s","ti"]
            
            for title in titles {
                let itemStackView = UIStackView()
                itemStackView.axis = .horizontal
                
                itemizedStackView.addArrangedSubview(itemStackView)
                
                let titleLabel = UILabel()
                titleLabel.text = title
                titleLabel.numberOfLines = 0
                titleLabel.font = UIFont.systemFont(ofSize: 14)
                
                itemStackView.addArrangedSubview(titleLabel)
                
                if title != "Due Date" {
                    let amountTextField = UITextField()
                    amountTextField.keyboardType = .decimalPad
                    amountTextField.borderStyle = .line
                    amountTextField.setDoneOnKeyboard()
                    
                    itemStackView.addArrangedSubview(amountTextField)
                    amountTextField.snp.makeConstraints({ make in
                        make.width.equalToSuperview().dividedBy(3)
                    })
                } else {
                    let dueDateTextField = UITextField()
                    dueDateTextField.keyboardType = .numberPad
                    dueDateTextField.borderStyle = .line
                    dueDateTextField.setDoneOnKeyboard()
                    
                    itemStackView.addArrangedSubview(dueDateTextField)
                    dueDateTextField.snp.makeConstraints({ make in
                        make.width.equalToSuperview().dividedBy(3)
                    })
                }
            }
        }
        
        bottomBackNextView.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        
        self.view.addSubview(bottomBackNextView)
        bottomBackNextView.snp.makeConstraints({ make in
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(110)
        })

        bottomBackNextView.backButton.isEnabled = (page != 0)
        bottomBackNextView.nextButton.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc func nextButtonTapped(_ sender: UIButton) {
        if sender == bottomBackNextView.nextButton {
//            if cellsSelectedTypes.contains(.null) {
//                let nextVC = ValuePickerViewController()
//                nextVC.page = page + 1
//                nextVC.cellData = cellData
//
//                self.navigationController?.pushViewController(nextVC, animated: true)
//            } else {
//                let nextVC = MultipleSelectionListViewController()
//                cellsSelectedTypes.forEach({ selectedType in
//                    nextVC.selectionData[selectedType] = [String:Int]()
//                })
//
//                nextVC.page = page + 1
//                nextVC.cellData = cellData
//
//                self.navigationController?.pushViewController(nextVC, animated: true)
//
//                //showAlertMessage(title: "Coming Soon", message: "")
//            }
        }
    }
}

