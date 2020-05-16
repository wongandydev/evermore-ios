//
//  FeedbackViewController.swift
//  EverMore
//
//  Created by Andy Wong on 5/16/20.
//  Copyright © 2020 Andy Wong. All rights reserved.
//

import UIKit
import Firebase

class FeedbackViewController: UIViewController {
    
    private let textView = UITextView()
    private let thankYouView = UIView()
    private let submitButton = UIButton()
    
    private let placeholderText = "Enter Feedback"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setupViews()
    }
    
    private func setupViews() {
        self.view.backgroundColor = .backgroundColor
        
        let closeButton = UIButton()
        closeButton.setImage(UIImage(named: "close"), for: .normal)
        closeButton.tintColor = .moneyGreenColor
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        
        self.view.addSubview(closeButton)
        closeButton.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(60)
            make.width.height.equalTo(50 * Constants.smallScreenTypeScale)
            make.left.equalToSuperview().offset(15)
        })
        
        let questionLabel = UILabel()
        questionLabel.numberOfLines = 0
        questionLabel.text = "Please let us know what we need to improve on."
        
        self.view.addSubview(questionLabel)
        questionLabel.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(140 * Constants.smallScreenTypeScale)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
        })
        
        textView.delegate = self
        textView.textColor = .placeholderGray
        textView.text = placeholderText
        textView.font = UIFont.systemFont(ofSize: 16, weight: .light)
        textView.setDoneOnKeyboard()
        
        self.view.addSubview(textView)
        textView.snp.makeConstraints({ make in
            make.top.equalTo(questionLabel.snp.bottom).offset(30 * Constants.smallScreenTypeScale)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(200 * Constants.smallScreenTypeScale)
            make.centerX.equalToSuperview()
        })
        
        let submitButton = UIButton()
        submitButton.setTitle("Submit", for: .normal)
        submitButton.setTitleColor(.textColor, for: .normal)
        submitButton.setTitleColor(.gray, for: .highlighted)
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        
        self.view.addSubview(submitButton)
        submitButton.snp.makeConstraints({ make in
            make.top.equalTo(textView.snp.bottom).offset(20 * Constants.smallScreenTypeScale)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
        })
        
        thankYouView.backgroundColor = UIColor.gray.withAlphaComponent(0.7)
        thankYouView.layer.cornerRadius = 8
        self.thankYouView.transform = CGAffineTransform(scaleX: 0, y:0)
        
        self.view.addSubview(thankYouView)
        thankYouView.snp.makeConstraints({ make in
            make.center.equalToSuperview()
            make.width.height.equalTo(150*Constants.smallScreenTypeScale)
        })
        
        let checkmarkImageView = UIImageView()
        checkmarkImageView.image = UIImage(named: "checkmark-100")
        checkmarkImageView.tintColor = .textColor
        
        thankYouView.addSubview(checkmarkImageView)
        checkmarkImageView.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(10)
            make.width.equalToSuperview().multipliedBy(0.6)
            make.centerX.equalToSuperview()
        })
        
        let submittedText = UILabel()
        submittedText.text = "Submitted!"
        submittedText.textColor = .textColor
        submittedText.textAlignment = .center
        
        thankYouView.addSubview(submittedText)
        submittedText.snp.makeConstraints({ make in
            make.top.equalTo(checkmarkImageView.snp.bottom).offset(10)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
        })
    }
    
    @objc private func submitButtonTapped() {
        // submit to firebase
        submitButton.isUserInteractionEnabled = false
        if let text = textView.text {
            if text != placeholderText {
                Database.database().reference().child("evermore/feedback").childByAutoId().setValue(["text": textView.text,
                                                                                                     "date": Int.currentTime()])
                
                UserDefaults.standard.set(true, forKey: Constants.defaultFeedbackGiven)
                // ok, thank message
                UIView.animate(withDuration: 0.3, animations: {
                    self.thankYouView.transform = CGAffineTransform(scaleX: 1, y: 1)
                })
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    self.dismiss(animated: true, completion: nil)
                }
            } else {
                submitButton.isUserInteractionEnabled = true
                showAlertMessage(title: "Error", message: "Please enter feedback. Thank you!")
            }
        }
        
        
        
    }
    
    @objc private func closeButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension FeedbackViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .placeholderGray {
            textView.textColor = .textColor
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.textColor = .placeholderGray
            textView.text = placeholderText
        }
    }
}
