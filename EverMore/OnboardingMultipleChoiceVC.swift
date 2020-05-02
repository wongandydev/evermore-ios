//
//  OnboardingMultipleChoiceVC.swift
//  EverMore
//
//  Created by Andy Wong on 5/2/20.
//  Copyright © 2020 Andy Wong. All rights reserved.
//

import UIKit
import SnapKit

class OnboardingMultipleChoiceViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let headerIdentifier = "onboardingHeaderView"
    let cellIdentifier = "onboardingCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        
        self.collectionView.backgroundColor = .clear
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.reloadData()
        
        self.collectionView.register(OnboardingHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        self.collectionView.register(OnboardingCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! OnboardingHeaderView

        headerView.text = "What debt do you have?"
        headerView.backgroundColor = UIColor.white.withAlphaComponent(0.14)

        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: self.collectionView.frame.size.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return .zero
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! OnboardingCell
        
        cell.text = "text \(indexPath.section) \(indexPath.row)"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 10, left: 0, bottom: 20, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.size.width-20, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}



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

class OnboardingCell: UICollectionViewCell {
    var text: String = "" {
        didSet {
            label.text = text
        }
    }
    
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.systemGray
        self.layer.cornerRadius = 10
        
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
