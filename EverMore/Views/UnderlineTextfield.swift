//
//  UnderlineTextfield.swift
//  EverMore
//
//  Created by Andy Wong on 5/11/20.
//  Copyright © 2020 Andy Wong. All rights reserved.
//

import UIKit

class UnderlineTextfield: UITextField {
    var placeHolderText: String = "" {
        didSet {
            self.attributedPlaceholder = NSAttributedString(string: placeHolderText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.defaultTextFieldPlaceholderColor])
        }
    }
    
    private var bottomBorder: CALayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setDoneOnKeyboard()
        setup()
    }
    
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 0, y: self.frame.height-2.0, width: self.frame.width, height: 1.0)
        bottomBorder.backgroundColor = UIColor.gray.withAlphaComponent(0.3).cgColor
        self.layer.addSublayer(bottomBorder)
    }

    private func setup() {
        self.font = UIFont(name: "Inter-Medium", size: 16*Constants.smallScreenTypeScale)
        self.backgroundColor = .clear
        self.textColor = .textColor
        self.textAlignment = .left
        self.clearButtonMode = .never
        self.clipsToBounds = false

        self.autocorrectionType = UITextAutocorrectionType.no
        self.autocapitalizationType = .none
        
        self.borderStyle = .none
    }
    
    
}
