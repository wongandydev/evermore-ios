//
//  TabBarViewController.swift
//  EverMore
//
//  Created by Andy Wong on 5/9/20.
//  Copyright © 2020 Andy Wong. All rights reserved.
//

import UIKit

class TabBarControlller: UITabBarController {
    let firstVC = HomeViewController()
    let secondVC = ReviewViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstVC.tabBarItem = UITabBarItem(title: "Home", image: nil, selectedImage: nil)
        secondVC.tabBarItem = UITabBarItem(title: "Budget", image: nil, selectedImage: nil)
        
        viewControllers = [firstVC, secondVC]
        
        self.tabBar.barStyle = .default
        self.tabBar.tintColor = .green
    }
}
