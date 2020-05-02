//
//  Extensions.swift
//  EverMore
//
//  Created by Andy Wong on 5/2/20.
//  Copyright © 2020 Andy Wong. All rights reserved.
//

import UIKit

class Extensions {
    
}

extension UIViewController {
    func showAlertMessage(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true)
    }
}
