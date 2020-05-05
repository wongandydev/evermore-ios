//
//  ValuePickerViewController.swift
//  EverMore
//
//  Created by Andy Wong on 5/2/20.
//  Copyright © 2020 Andy Wong. All rights reserved.
//

import UIKit

class ValuePickerViewController: UIViewController {
    var budget: Budget!
    var page: Int!
    var cellData: [OnboardingInfo]!
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        self.view.backgroundColor = .systemBackground
        
        let questionLabel = UILabel()
        questionLabel.text = cellData[page].question
        questionLabel.numberOfLines = 0
        
        self.view.addSubview(questionLabel)
        questionLabel.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(140)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
        })
    }
}
