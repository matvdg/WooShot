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
    @IBOutlet weak var activitySpin: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.elements.layer.zPosition = 1
        self.view.tintColor = Color.wooColor
        self.view.backgroundColor = Color.wooColor
        self.signUpButton.isHidden = true
        self.emailField.isHidden = true
        self.passwordField.isHidden = true
        self.title = NSLocalizedString("SIGNUP", comment: "signup in navbar title")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.designAndAnimateButtons()
    }
    
    private func designAndAnimateButtons() {
        let login = self.signUpButton!
        login.titleLabel?.adjustsFontSizeToFitWidth = true
        login.layer.borderWidth = 1
        login.layer.borderColor = UIColor.white.cgColor
        login.layer.cornerRadius = login.bounds.height/2
        login.backgroundColor = UIColor.clear
        login.setTitleColor(UIColor.white, for: .normal)
        self.emailField.layer.position.x -= self.view.bounds.width
        self.passwordField.layer.position.x -= self.view.bounds.width
        self.signUpButton.alpha = 0
        self.signUpButton.isHidden = false
        self.emailField.isHidden = false
        self.emailField.alpha = 0.25
        self.passwordField.alpha = 0.25

        
        
        self.passwordField.isHidden = false
        if let user = FIRAuth.auth()?.currentUser {
            self.signedUp(user)
        }
        //animations
        UIView.animate(withDuration: 1, delay: 0.00, options: UIViewAnimationOptions(), animations: {
            self.emailField.layer.position.x += self.view.bounds.width
            self.passwordField.layer.position.x += self.view.bounds.width
            self.view.layoutIfNeeded()
            }, completion: nil)
        UIView.animate(withDuration: 1.5, delay: 0.30, options: .curveEaseOut, animations: { self.signUpButton.alpha = 1 }, completion: nil)
    }
    
    @IBAction func didTapSignUp(_ sender: UIButton) {
        self.activitySpin.startAnimating()
        // Sign In with credentials.
        let email = emailField.text!
        let password = passwordField.text!
        if email.isEmpty || password.isEmpty {
            // create alert controller
            let myAlert = UIAlertController(title: NSLocalizedString("ERROR", comment: "error"), message: NSLocalizedString("EMPTY", comment: "empty field"), preferredStyle: UIAlertControllerStyle.alert)
            myAlert.view.tintColor = Color.wooColor
            // add "OK" button
            myAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            // show the alert
            self.present(myAlert, animated: true, completion: nil)
            self.activitySpin.stopAnimating()
            
        } else {
            FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
                if let error = error {
                    // create alert controller
                    let myAlert = UIAlertController(title: NSLocalizedString("ERROR", comment: "error"), message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    myAlert.view.tintColor = Color.wooColor
                    // add "OK" button
                    myAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    // show the alert
                    self.present(myAlert, animated: true, completion: nil)
                    self.activitySpin.stopAnimating()
                    return
                }
                self.setDisplayName(user!)
            }
        }
            
    }
    
    func setDisplayName(_ user: FIRUser) {
        let changeRequest = user.profileChangeRequest()
        changeRequest.displayName = user.email!.components(separatedBy: "@")[0]
        changeRequest.commitChanges(){ (error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            self.signedUp(FIRAuth.auth()?.currentUser)
            print(user.email, user.displayName)
        }
    }
    
    func signedUp(_ user: FIRUser?) {
        self.activitySpin.stopAnimating()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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

