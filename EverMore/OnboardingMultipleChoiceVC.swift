//
//  OnboardingMultipleChoiceVC.swift
//  EverMore
//
//  Created by Andy Wong on 5/2/20.
//  Copyright © 2020 Andy Wong. All rights reserved.
//

import UIKit

class OnboardingMultipleChoiceViewController: UICollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


class OnboardingHeaderView: UICollectionReusableView {
    var text: String = "" {
        didSet {
            label.text = text
        }
    }
    var label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label.text = ""
        label.numberOfLines = 0
        
        self.addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class OnbaordingCell: UICollectionViewCell {
    
}
