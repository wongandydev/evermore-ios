//
//  HomeViewController.swift
//  EverMore
//
//  Created by Andy Wong on 5/9/20.
//  Copyright © 2020 Andy Wong. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    var budget = BudgetManager.get()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if budget.goal == nil {
            budget.setGoal()
        }
        
    }
}
