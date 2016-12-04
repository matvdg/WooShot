//
//  UIViewController + UIAlertViewController.swift
//  WooShot
//
//  Created by Mathieu Vandeginste on 04/12/2016.
//  Copyright © 2016 WooShot. All rights reserved.
//

import UIKit

extension UIViewController {
    
    public func presentErrorAlertViewController(message: String) {
        // create alert controller
        let myAlert = UIAlertController(title: NSLocalizedString("ERROR", comment: "error"), message: message, preferredStyle: .alert)
        myAlert.view.tintColor = UIColor.wooColor
        // add "OK" button
        myAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        // show the alert
        self.present(myAlert, animated: true, completion: nil)
    }
    
    public func presentAlertViewController(title: String, message: String) {
        // create alert controller
        let myAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        myAlert.view.tintColor = UIColor.wooColor
        // add "OK" button
        myAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        // show the alert
        self.present(myAlert, animated: true, completion: nil)
    }
}
