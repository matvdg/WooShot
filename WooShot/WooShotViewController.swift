//
//  WooShotViewController.swift
//  WooShot
//
//  Created by Mathieu Vandeginste on 19/09/2016.
//  Copyright © 2016 WooShot. All rights reserved.
//

import UIKit

class WooShotViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.addSublayer(Color.getGradient(view: self.view))
    }

}
