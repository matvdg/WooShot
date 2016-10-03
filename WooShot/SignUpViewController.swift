//
//  SignUpViewController.swift
//  WooShot
//
//  Created by Mathieu Vandeginste on 09/09/2016.
//  Copyright © 2016 WooShot. All rights reserved.
//


  

import UIKit
import Firebase

class SignUpViewController: WooShotViewController, UITextFieldDelegate {
    
    @IBOutlet weak var elements: UIView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var separator: UIView!
    @IBOutlet weak var confidentiality: UIButton!
    @IBOutlet weak var activitySpin: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.elements.layer.zPosition = 1
        self.view.tintColor = Color.wooColor
        self.confidentiality.isHidden = true
        self.signUpButton.isHidden = true
        self.emailField.isHidden = true
        self.passwordField.isHidden = true
        self.separator.isHidden = true
        self.title = NSLocalizedString("SIGNUP", comment: "signup in navbar title")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.designAndAnimateButtons()
        self.emailField.becomeFirstResponder()
    }
    
    private func designAndAnimateButtons() {
        let whitePlaceholder = UIColor(white: 1, alpha: 0.54)
        let signup = self.signUpButton!
        let email = self.emailField!
        let password = self.passwordField!
        let separator = self.separator!
        let policy = self.confidentiality!
        
        signup.titleLabel?.adjustsFontSizeToFitWidth = true
        signup.layer.cornerRadius = signup.bounds.height/2
        signup.backgroundColor = UIColor.white
        signup.setTitleColor(Color.wooColor, for: .normal)
        email.layer.position.x -= self.view.bounds.width
        password.layer.position.x -= self.view.bounds.width
        separator.layer.position.x -= self.view.bounds.width
        signup.alpha = 0
        policy.alpha = 0
        signup.isHidden = false
        email.isHidden = false
        password.isHidden = false
        separator.isHidden = false
        policy.isHidden = false
        email.attributedPlaceholder = NSAttributedString(string:NSLocalizedString("PLACEHOLDER_EMAIL", comment: "email"),attributes:[NSForegroundColorAttributeName: whitePlaceholder])
        email.textColor = UIColor.white
        password.textColor = UIColor.white
        password.attributedPlaceholder = NSAttributedString(string:NSLocalizedString("PLACEHOLDER_PWD", comment: "password"),attributes:[NSForegroundColorAttributeName: whitePlaceholder])
        //animations
        UIView.animate(withDuration: 0.5, delay: 0.00, options: UIViewAnimationOptions(), animations: {
            email.layer.position.x += self.view.bounds.width
            password.layer.position.x += self.view.bounds.width
            separator.layer.position.x += self.view.bounds.width
            self.view.layoutIfNeeded()
            }, completion: nil)
        UIView.animate(withDuration: 1.0, delay: 0.30, options: .curveEaseOut, animations: {
            signup.alpha = 1
            policy.alpha = 1
            
            }, completion: nil)
    }
    
    @IBAction func didTapSignUp(_ sender: UIButton) {
//        self.activitySpin.startAnimating()
//        let email = emailField.text!
//        let password = passwordField.text!
//        if email.isEmpty || password.isEmpty { //error
//            // create alert controller
//            let myAlert = UIAlertController(title: NSLocalizedString("ERROR", comment: "error"), message: NSLocalizedString("EMPTY", comment: "empty field"), preferredStyle: UIAlertControllerStyle.alert)
//            myAlert.view.tintColor = Color.wooColor
//            // add "OK" button
//            myAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
//            // show the alert
//            self.present(myAlert, animated: true, completion: nil)
//            self.activitySpin.stopAnimating()
//            
//        } else { //auth ok
//            FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
//                if let error = error {
//                    // create alert controller
//                    let myAlert = UIAlertController(title: NSLocalizedString("ERROR", comment: "error"), message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
//                    myAlert.view.tintColor = Color.wooColor
//                    // add "OK" button
//                    myAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
//                    // show the alert
//                    self.present(myAlert, animated: true, completion: nil)
//                    self.activitySpin.stopAnimating()
//                    return
//                }
//                //let's go!
//                self.activitySpin.stopAnimating()
                self.performSegue(withIdentifier: "firstLaunch", sender: self)
//            }
//        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag: NSInteger = textField.tag + 1
        // Try to find next responder
        let nextResponder: UIResponder? = textField.superview?.viewWithTag(nextTag)
        
        if ((nextResponder) != nil) {
            // Found next responder, so set it.
            nextResponder!.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        return false
        // We do not want UITextField to insert line-breaks.
    }
    
 

    
}

