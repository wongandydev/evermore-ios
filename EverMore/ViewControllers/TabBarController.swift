//
//  TabBarViewController.swift
//  EverMore
//
//  Created by Andy Wong on 5/9/20.
//  Copyright © 2020 Andy Wong. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    let firstVC = HomeViewController()
    let secondVC = ReviewViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home"), selectedImage: UIImage(named: "home"))
        secondVC.tabBarItem = UITabBarItem(title: "Budget", image: UIImage(named: "review"), selectedImage: UIImage(named: "review"))
        
        viewControllers = [firstVC, secondVC]
        
        self.tabBar.barStyle = .default
        self.tabBar.tintColor = .green
        self.tabBar.isTranslucent = false
    }
}
