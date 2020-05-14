//
//  CategoryLabel.swift
//  EverMore
//
//  Created by Andy Wong on 5/12/20.
//  Copyright © 2020 Andy Wong. All rights reserved.
//

import UIKit

class CategoryLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        self.numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
