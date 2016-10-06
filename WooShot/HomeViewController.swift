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
        elements.layer.zPosition = 1
        let nav = navigationController!.navigationBar
        nav.barTintColor = Color.wooColorDark
        nav.tintColor = UIColor.white
        nav.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        let backItem = UIBarButtonItem()
        backItem.title = NSLocalizedString("HOME", comment: "back button")
        navigationItem.backBarButtonItem = backItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        designButtons()
    }
    
    private func designButtons() {
        let layer = fbloginButton.layer
        layer.cornerRadius = fbloginButton.frame.height / 2
        fbloginButton.titleLabel?.adjustsFontSizeToFitWidth = true
//        layer.shadowOffset = CGSize(width: -1, height: 1)
//        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowOpacity = 0.5
        let signUp = signUpButton!
        signUp.titleLabel?.adjustsFontSizeToFitWidth = true
        loginButton.titleLabel?.adjustsFontSizeToFitWidth = true
        //loginButton.backgroundColor = Color.p600
//        signUp.layer.borderWidth = 1
//        signUp.layer.borderColor = UIColor.white.cgColor
//        signUp.layer.cornerRadius = signUp.bounds.height/2
    }


}
