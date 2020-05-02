//
//  BottomBackNextView.swift
//  EverMore
//
//  Created by Andy Wong on 5/2/20.
//  Copyright © 2020 Andy Wong. All rights reserved.
//

import UIKit

class BottomBackNextView: UIView {
    let backButton = UIButton()
    let nextButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        
        backButton.setTitle("Back", for: .normal)
        backButton.backgroundColor = .gray
        backButton.layer.cornerRadius = 8
        backButton.setTitleColor(.gray, for: .disabled)
        
        self.addSubview(backButton)
        backButton.snp.makeConstraints({ make in
            make.left.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview().inset(20)
            make.width.equalToSuperview().dividedBy(2).offset(-30)
        })
        
        
        nextButton.setTitle("Next", for: .normal)
        nextButton.backgroundColor = .darkGray
        nextButton.layer.cornerRadius = 8
        nextButton.isEnabled = false
        nextButton.setTitleColor(.gray, for: .disabled)
        
        self.addSubview(nextButton)
        nextButton.snp.makeConstraints({ make in
            make.right.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview().inset(20)
            make.width.equalToSuperview().dividedBy(2).offset(-30)
        })

    }
    
}
