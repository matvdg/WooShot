//
//  HomeViewController.swift
//  WooShot
//
//  Created by Mathieu Vandeginste on 09/09/2016.
//  Copyright © 2016 WooShot. All rights reserved.
//

import UIKit

class HomeViewController: WooShotViewController {

    @IBOutlet weak var elements: UIView!
    
    @IBOutlet weak var fbloginButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    override func viewDidLoad() {
//        let loginButton = LoginButton(readPermissions: [ .PublicProfile ])
//        loginButton.center = view.center
        
        //view.addSubview(loginButton)
        super.viewDidLoad()
        self.elements.layer.zPosition = 1
        let nav = self.navigationController!.navigationBar
        nav.barTintColor = Color.wooColorDark
        nav.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        let backItem = UIBarButtonItem()
        backItem.title = NSLocalizedString("HOME", comment: "back button")
        navigationItem.backBarButtonItem = backItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.designButtons()
    }
    
    private func designButtons() {
        let layer = self.fbloginButton.layer
        layer.cornerRadius = self.fbloginButton.frame.height / 2
        self.fbloginButton.titleLabel?.adjustsFontSizeToFitWidth = true
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        let signUp = self.signUpButton!
        signUp.titleLabel?.adjustsFontSizeToFitWidth = true
        self.loginButton.titleLabel?.adjustsFontSizeToFitWidth = true
        self.loginButton.backgroundColor = Color.wooColorDark
        signUp.layer.borderWidth = 1
        signUp.layer.borderColor = UIColor.white.cgColor
        signUp.layer.cornerRadius = signUp.bounds.height/2
    }


}
