//
//  OnboardingScrollView.swift
//  EverMore
//
//  Created by Andy Wong on 5/14/20.
//  Copyright © 2020 Andy Wong. All rights reserved.
//

import UIKit

class OnboardingScrollViewViewController: UIViewController {
    private let scrollView = UIScrollView()
    
    private let pages = [
        ["text": "Welcome to Evermore!", "image": UIImage(named: "home")],
        ["text": "Evermore is in beta. We are trying to add new features all the time. But here is how it works.", "image": UIImage(named: "home")]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        setupViews()
    }
    
    private func setupViews() {
        self.view.backgroundColor = .backgroundColor
        
        scrollView.backgroundColor = .green
        scrollView.bounces = true
        scrollView.isPagingEnabled = true
        
        
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints({ make in
            make.edges.equalTo(self.view)
        })
        
        scrollView.contentSize = CGSize(width: self.view.frame.size.width * CGFloat(pages.count), height: scrollView.frame.size.height)
        
        for (index, page) in pages.enumerated() {
            let xOffset = self.view.frame.width * CGFloat(index)
            
            let view = UIView()
            view.backgroundColor = [.blue,.red][index]
            
            scrollView.addSubview(view)
            view.snp.makeConstraints({ make in
                make.left.equalToSuperview().offset(xOffset)
                make.width.equalToSuperview()
                make.height.equalToSuperview()
                make.top.equalTo(self.view)
            })
        }
    }
}
