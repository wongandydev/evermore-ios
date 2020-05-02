//
//  OnboardingHeaderView.swift
//  EverMore
//
//  Created by Andy Wong on 5/2/20.
//  Copyright © 2020 Andy Wong. All rights reserved.
//

import UIKit

class OnboardingHeaderView: UICollectionReusableView {
    var text: String = "" {
        didSet {
            label.text = text
        }
    }
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label.text = text
        label.numberOfLines = 0
        label.textAlignment = .left
        
        self.addSubview(label)
        label.snp.makeConstraints({ make in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.center.equalToSuperview()
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


