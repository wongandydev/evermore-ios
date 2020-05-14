//
//  OnboardingScrollView.swift
//  EverMore
//
//  Created by Andy Wong on 5/14/20.
//  Copyright © 2020 Andy Wong. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {
    private let scrollView = UIScrollView()
    private let pageIndicator = UIPageControl()
    
    private let pages = [
        ["text": "Welcome to \nEvermore!", "image": UIImage(named: "welcome")],
        ["text": "Evermore is in beta. We are trying to add new features all the time. But here is how it works.", "image": UIImage(named: "beta")],
        ["text": "1. Add your debt and when you plan to pay it off. (If you don't have any good for you! If you do that's okay.) \n80% of Americans do!", "image": UIImage(named: "debt")],
        ["text": "2. Add how much you make. Daily, Weekly, Bi-Weekly or Monthly. (We do not do yearly because we think knowing how much you make in a closer interval keeps your brain budgetting!)", "image": UIImage(named: "salary")],
        ["text": "3. Lastly, add you savings goal. How much do you want to save?", "image": UIImage(named: "saving")],
        ["text": "That's it!\nTap 'Get Started', to start your budgetting journey!", "image": UIImage(named: "done")]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        setupViews()
    }
    
    private func setupViews() {
        self.view.backgroundColor = .backgroundColor
    
        scrollView.bounces = true
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints({ make in
            make.edges.equalTo(self.view)
        })
        
        scrollView.contentSize = CGSize(width: self.view.frame.size.width * CGFloat(pages.count), height: scrollView.frame.size.height)
        
        pageIndicator.currentPage = 0
        pageIndicator.numberOfPages = pages.count
        pageIndicator.currentPageIndicatorTintColor = .moneyGreenColor
        pageIndicator.pageIndicatorTintColor = UIColor.moneyGreenColor?.withAlphaComponent(0.7)
        
        self.view.addSubview(pageIndicator)
        pageIndicator.snp.makeConstraints({ make in
            make.bottom.equalToSuperview().offset(-20)
            make.centerX.equalToSuperview()
        })
        
        for (index, page) in pages.enumerated() {
            let xOffset = self.view.frame.width * CGFloat(index)
            
            let view = UIView()
            
            scrollView.addSubview(view)
            view.snp.makeConstraints({ make in
                make.left.equalToSuperview().offset(xOffset)
                make.width.equalToSuperview()
                make.height.equalToSuperview()
                make.top.equalTo(self.view)
            })
            
            let imageViewWidthHeight = (200) * Constants.smallScreenTypeScale
            
            let imageView = UIImageView()
            imageView.image = page["image"] as? UIImage
            imageView.clipsToBounds = true
            
            if index == 1 {
                imageView.tintColor = .moneyGreenColor
            }
            
            imageView.layer.cornerRadius = imageViewWidthHeight/2
            
            view.addSubview(imageView)
            imageView.snp.makeConstraints({ make in
                make.width.height.equalTo(imageViewWidthHeight)
                make.centerX.equalToSuperview()
                make.bottom.equalTo(view.snp.centerY).offset(-60)
            })
            
            let textLabel = UILabel()
            textLabel.text = page["text"] as? String
            textLabel.numberOfLines = 0
            textLabel.textAlignment = .center
            textLabel.font = index == 0 || index == pages.count - 1 ? UIFont.systemFont(ofSize: 24, weight: .semibold) : UIFont.systemFont(ofSize: 16)
            
            view.addSubview(textLabel)
            textLabel.snp.makeConstraints({ make in
                make.top.equalTo(view.snp.centerY).offset(80)
                make.width.equalToSuperview().multipliedBy(0.8)
                make.centerX.equalToSuperview()
            })
            
            if index == pages.count - 1 {
                let getStartedButton = UIButton()
                getStartedButton.setTitle("Get Started", for: .normal)
                getStartedButton.setTitleColor(.gray, for: .highlighted)
                getStartedButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
                getStartedButton.layer.cornerRadius = 15
                getStartedButton.addTarget(self, action: #selector(getStartedButtonTapped), for: .touchUpInside)
                getStartedButton.backgroundColor = .moneyGreenColor
                
                view.addSubview(getStartedButton)
                getStartedButton.snp.makeConstraints({ make in
                    make.top.equalTo(textLabel.snp.bottom).offset(20 * Constants.smallScreenTypeScale)
                    make.height.equalTo(50)
                    make.width.equalToSuperview().multipliedBy(0.8)
                    make.centerX.equalToSuperview()
                })
            }
        }
    }
    
    @objc private func getStartedButtonTapped() {
        let nextVC = OnboardingMultipleChoiceViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let navVC = UINavigationController(rootViewController: nextVC)
        
        UserDefaults.standard.set(true, forKey: Constants.defaultTutorialCompleted)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = navVC
        appDelegate.window?.makeKeyAndVisible()
    }
}

extension TutorialViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x/scrollView.frame.size.width)
        pageIndicator.currentPage = Int(pageNumber)
    }
}
