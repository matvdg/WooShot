//
//  AppleMusicButton.swift
//  WooShot
//
//  Created by Mathieu Vandeginste on 18/10/2016.
//  Copyright © 2016 WooShot. All rights reserved.
//

import UIKit

@IBDesignable public class AppleMusicButton: UIButton {
    
    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.bounds.height / 2
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        clipsToBounds = true
    }
}
