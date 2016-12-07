//
//  HomeViewController.swift
//  WooShot
//
//  Created by Mathieu Vandeginste on 09/09/2016.
//  Copyright © 2016 WooShot. All rights reserved.
//

import UIKit
import FacebookLogin

class HomeViewController: WooShotViewController {

    @IBOutlet weak var elements: UIView!
    
    @IBOutlet weak var fbloginButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        elements.layer.zPosition = 1
        let nav = navigationController!.navigationBar
        nav.barTintColor = UIColor.wooColorDark
        nav.tintColor = UIColor.white
        nav.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        let backItem = UIBarButtonItem()
        backItem.title = NSLocalizedString("HOME", comment: "back button")
        navigationItem.backBarButtonItem = backItem
        self.fbloginButton.addTarget(self, action: #selector(didTouchFb), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        designButtons()
    }
    
    private func designButtons() {
        let signUp = signUpButton!
        signUp.titleLabel?.adjustsFontSizeToFitWidth = true
        loginButton.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    func didTouchFb() {
        let loginManager = LoginManager()
        loginManager.logIn([ .publicProfile ], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                self.presentErrorAlertViewController(message: error.localizedDescription)
            case .cancelled:
                print("User cancelled login.")
            case .success(_, _, let accessToken):
                print(accessToken)
                break
            }
        }
    }


}
