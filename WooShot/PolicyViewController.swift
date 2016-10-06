//
//  PolicyViewController.swift
//  WooShot
//
//  Created by Mathieu Vandeginste on 26/09/2016.
//  Copyright © 2016 WooShot. All rights reserved.
//

import UIKit

class PolicyViewController: UIViewController {

    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var policy: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissButton.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        dismissButton.alpha = 0
        dismissButton.isHidden = false
        dismissButton.layer.cornerRadius = dismissButton.bounds.height/2
        dismissButton.backgroundColor = Color.wooColor
        dismissButton.setTitleColor(UIColor.white, for: .normal)
        //animation
        UIView.animate(withDuration: 1.0, delay: 0.30, options: .curveEaseOut, animations: { self.dismissButton.alpha = 1 }, completion: nil)
    }

    @IBAction func dismiss(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    

}
