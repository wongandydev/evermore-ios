//
//  Extensions.swift
//  EverMore
//
//  Created by Andy Wong on 5/2/20.
//  Copyright © 2020 Andy Wong. All rights reserved.
//

import UIKit
import StoreKit

class Extensions {
    static func dateToDisplayString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/yyyy"
        dateFormatter.timeZone = TimeZone.current
        
        return dateFormatter.string(from: date)
    }
}

extension UIViewController {
    func showAlertMessage(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true)
    }
    
    func showFeedbackAlertMessage() {
        let alertController = UIAlertController(title: "Are you enjoying Evermore?", message: "", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: .cancel, handler: { action in
            SKStoreReviewController.requestReview()
            UserDefaults.standard.set(true, forKey: Constants.defaultFeedbackGiven)
        })
        
        alertController.addAction(yesAction)
        
        let noAction = UIAlertAction(title: "No", style: .default, handler: { action in
            // let us know why
            let feedbackVC = FeedbackViewController()
            feedbackVC.modalPresentationStyle = .overFullScreen
            
            

            self.present(feedbackVC, animated: true, completion: nil)
            
            
        })
        alertController.addAction(noAction)
        
        self.present(alertController, animated: true)
    }
}

extension UITextField {
    func setDoneOnKeyboard() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissKeyboard))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        self.inputAccessoryView = keyboardToolbar
    }

    @objc func dismissKeyboard() {
        self.resignFirstResponder()
    }
}

extension UITextView {
    func setDoneOnKeyboard() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissKeyboard))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        self.inputAccessoryView = keyboardToolbar
    }

    @objc func dismissKeyboard() {
        self.resignFirstResponder()
    }
}

extension Date {
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
}

extension Double {
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

extension UIColor {
    static let textColor = UIColor(named: "textColor")
    static let backgroundColor = UIColor(named: "background")
    static let moneyGreenColor = UIColor(named: "moneyGreen")
    static let defaultTextFieldPlaceholderColor = UIColor(hue: 50/360, saturation: 100/100, brightness: 0/100, alpha: 0.3)
        static let placeholderGray                      = UIColor(red: 178/225, green: 178/225, blue: 178/225, alpha: 1.0)
}

extension Int {
    static func currentTime() -> Int {
        return Int(Date().timeIntervalSince1970)
    }
}
