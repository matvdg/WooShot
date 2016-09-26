//
//  PolicyViewController.swift
//  WooShot
//
//  Created by Mathieu Vandeginste on 26/09/2016.
//  Copyright © 2016 WooShot. All rights reserved.
//

import UIKit

class PolicyViewController: WooShotViewController {

    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var policy: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.zPosition = 10
        dismissButton.layer.cornerRadius = dismissButton.bounds.height/2
        dismissButton.backgroundColor = Color.wooColor
        dismissButton.setTitleColor(UIColor.white, for: .normal)
    }

    @IBAction func dismiss(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
