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
        elements.layer.zPosition = 1
        view.tintColor = Color.wooColor
        confidentiality.isHidden = true
        signUpButton.isHidden = true
        emailField.isHidden = true
        passwordField.isHidden = true
        separator.isHidden = true
        title = NSLocalizedString("SIGNUP", comment: "signup in navbar title")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        designAndAnimateButtons()
        emailField.becomeFirstResponder()
    }
    
    private func designAndAnimateButtons() {
        let whitePlaceholder = UIColor(white: 1, alpha: 0.54)
        let signup = signUpButton!
        let email = emailField!
        let password = passwordField!
        let separator = self.separator!
        let policy = confidentiality!
        signup.backgroundColor = UIColor.white
        signup.setTitleColor(Color.wooColor, for: .normal)
        email.layer.position.x -= view.bounds.width
        password.layer.position.x -= view.bounds.width
        separator.layer.position.x -= view.bounds.width
        signup.alpha = 0
        policy.alpha = 0
        signup.isHidden = false
        email.isHidden = false
        password.isHidden = false
        separator.isHidden = false
        policy.isHidden = false
        policy.setTitle(NSLocalizedString("POLICY", comment: ""), for: .normal)
        email.attributedPlaceholder = NSAttributedString(string:NSLocalizedString("PLACEHOLDER_EMAIL", comment: "email"),attributes:[NSForegroundColorAttributeName: whitePlaceholder])
        email.textColor = UIColor.white
        password.textColor = UIColor.white
        password.attributedPlaceholder = NSAttributedString(string:NSLocalizedString("PLACEHOLDER_PWD", comment: "password"),attributes:[NSForegroundColorAttributeName: whitePlaceholder])
        
        //animations
        UIView.animate(withDuration: 0.25) { 
            email.layer.position.x += self.view.bounds.width
            password.layer.position.x += self.view.bounds.width
            separator.layer.position.x += self.view.bounds.width
            signup.alpha = 1
            policy.alpha = 1
        }
    }
    
    @IBAction func didTapSignUp(_ sender: UIButton) {
//        activitySpin.startAnimating()
//        let email = emailField.text!
//        let password = passwordField.text!
//        if email.isEmpty || password.isEmpty { //error
//            // create alert controller
//            let myAlert = UIAlertController(title: NSLocalizedString("ERROR", comment: "error"), message: NSLocalizedString("EMPTY", comment: "empty field"), preferredStyle: UIAlertControllerStyle.alert)
//            myAlert.view.tintColor = Color.wooColor
//            // add "OK" button
//            myAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
//            // show the alert
//            present(myAlert, animated: true, completion: nil)
//            activitySpin.stopAnimating()
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
//                    present(myAlert, animated: true, completion: nil)
//                    activitySpin.stopAnimating()
//                    return
//                }
//                //let's go!
//                activitySpin.stopAnimating()
                performSegue(withIdentifier: "firstLaunch", sender: self)
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

