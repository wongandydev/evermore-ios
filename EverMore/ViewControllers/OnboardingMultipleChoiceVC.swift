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
    private let headerIdentifier = "onboardingHeaderView"
    private let cellIdentifier = "onboardingCell"
    private var nullIndexPath: IndexPath?
    
    private let bottomBackNextView = BottomBackNextView()
    

    private var cellsSelectedTypes = [SelectionType]() {
        didSet {
            if cellsSelectedTypes.count > 0 {
                bottomBackNextView.nextButton.isEnabled = true
            } else {
                bottomBackNextView.nextButton.isEnabled = false
            }
        }
    }
    
    var page: Int = 0
    var cellData = [
        OnboardingInfo(pageNumber: 0, dataType: .multipleChoice, categoryTitle: "Debt", question: "What debt do you owe right now?", cellText: ["Credit Card", "Student Loans", "Auto/Home Loans", "None"], multipleSelectionTypes: nil),
         OnboardingInfo(pageNumber: 1, dataType: .multipleSelectionList, categoryTitle: "Debt", question: nil, cellText: nil, multipleSelectionTypes: nil),
        OnboardingInfo(pageNumber: 2, dataType: .valuePicker, categoryTitle: "Salary", question: "How much do you make?", cellText: nil, multipleSelectionTypes: nil)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.isHidden = true
        
        setupCollectionVC()
        setupViews()
    }
    
    private func setupCollectionVC() {
        self.collectionView.backgroundColor = .clear
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.allowsMultipleSelection = true
        
        registerCellsAndViews()
    }
    
    private func registerCellsAndViews() {
        self.collectionView.register(OnboardingHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        self.collectionView.register(OnboardingCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    private func setupViews() {
        bottomBackNextView.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        
        self.view.addSubview(bottomBackNextView)
        bottomBackNextView.snp.makeConstraints({ make in
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(110)
        })

        bottomBackNextView.backButton.isEnabled = (page != 0)
        bottomBackNextView.nextButton.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
    }
    
    // MARK: - Button Funcs
    
    @objc func nextButtonTapped(_ sender: UIButton) {
        if sender == bottomBackNextView.nextButton {
            if cellsSelectedTypes.contains(.null) {
                let nextVC = ValuePickerViewController()
                nextVC.page = page + 2
                nextVC.cellData = cellData
                
                self.navigationController?.pushViewController(nextVC, animated: true)
            } else {
                let nextVC = MultipleSelectionListViewController()
                cellsSelectedTypes.forEach({ selectedType in
                    nextVC.selectionData[selectedType] = [String:Int]()
                })
                
                nextVC.page = page + 1
                nextVC.cellData = cellData
                
                self.navigationController?.pushViewController(nextVC, animated: true)
                
                //showAlertMessage(title: "Coming Soon", message: "")
            }
        }
    }
}

// MARK: - CollectionView Delegate,DataSource, FlowLayout

extension OnboardingMultipleChoiceViewController {
    // MARK: Delegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) is OnboardingCell else { return }
        
        let cellSelectionType = SelectionType(string: cellData[page].cellText![indexPath.row])
        if cellSelectionType == .null {
            cellsSelectedTypes.removeAll()
            
            // deselect all if null
            if let selectedItems = collectionView.indexPathsForSelectedItems {
                for selectedIndexPath in selectedItems {
                    if selectedIndexPath != indexPath {
                        collectionView.deselectItem(at: selectedIndexPath, animated:true)
                    }
                    
                }
            }
        } else {
            cellsSelectedTypes.removeAll(where: { $0 == .null})
            
            // deselect null
            if let nullIndexPath = nullIndexPath {
                collectionView.deselectItem(at: nullIndexPath, animated:true)
            }
        }
        
        cellsSelectedTypes.append(cellSelectionType)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) is OnboardingCell else { return }
        
        let cellSelectionType = SelectionType(string: cellData[page].cellText![indexPath.row])
        cellsSelectedTypes.removeAll(where: { $0 == cellSelectionType})
    }
    
    // MARK: DataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellData[page].cellText!.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! OnboardingHeaderView

        headerView.text = cellData[page].question ?? ""
        headerView.backgroundColor = UIColor.white.withAlphaComponent(0.14)

        return headerView
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! OnboardingCell
        let selectionType = SelectionType(string: cellData[page].cellText![indexPath.row])
        
        cell.text = cellData[page].cellText![indexPath.row]
        cell.selectionType = selectionType
        
        if selectionType == .null {
            self.nullIndexPath = indexPath
        }
        
        return cell
    }
    
    // MARK: Layout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: self.collectionView.frame.size.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 10, left: 0, bottom: 140, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.size.width-20, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}


struct OnboardingInfo {
    var pageNumber: Int!
    var dataType: DataType!
    var categoryTitle: String?
    var question: String?
    var cellText: [String]?
    var multipleSelectionTypes: [SelectionType]?
}

enum DataType {
    case multipleChoice, multipleSelectionList, valuePicker, singleChoice, review
}

enum SelectionType: String {
    typealias RawValue = String
    
    case creditCard, studentLoan, autoHomeLoan, itemToSave, null
    
    init(string: String) {
        switch string{
        case "Credit Card":
            self = .creditCard
        case "Student Loans":
            self = .studentLoan
        case "Auto/Home Loans":
            self = .autoHomeLoan
        default:
            self = .null
        }
    }
}

