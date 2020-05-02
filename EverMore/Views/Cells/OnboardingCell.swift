//
//  OnboardingCell.swift
//  EverMore
//
//  Created by Andy Wong on 5/2/20.
//  Copyright © 2020 Andy Wong. All rights reserved.
//

import UIKit

class OnboardingCell: UICollectionViewCell {
    var text: String = "" {
        didSet {
            label.text = text
        }
    }
    
    var selectionType: SelectionType?
    
    override var isSelected: Bool {
        didSet {
            checkmarkImageView.isHidden = !isSelected
        }
    }
    
    private let label = UILabel()
    private let checkmarkImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(named: "gray")
        self.layer.cornerRadius = 10
        
        label.text = text
        label.numberOfLines = 0
        label.textAlignment = .left
        
        self.addSubview(label)
        label.snp.makeConstraints({ make in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.center.equalToSuperview()
        })
        
        checkmarkImageView.image = UIImage(named: "checkmark-100")
        checkmarkImageView.tintColor = .systemBlue
        checkmarkImageView.isHidden = true
        
        self.addSubview(checkmarkImageView)
        checkmarkImageView.snp.makeConstraints({ make in
            make.width.height.equalTo(25)
            make.right.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
