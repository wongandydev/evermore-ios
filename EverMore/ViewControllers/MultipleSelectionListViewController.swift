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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        
        print(selectionData)
        
        for (index, key) in selectionData.keys.enumerated() {
            let label = UILabel()
            label.text = key.rawValue
            
            self.view.addSubview(label)
            label.snp.makeConstraints({ make in
                make.width.equalToSuperview().multipliedBy(0.8)
                make.centerY.equalToSuperview().offset(index * 10)
            })
        }
    }
}
