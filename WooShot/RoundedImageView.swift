//
//  RoundedImageView.swift
//  WooShot
//
//  Created by Mathieu Vandeginste on 18/10/2016.
//  Copyright © 2016 WooShot. All rights reserved.
//

import UIKit

@IBDesignable public class RoundedImageView: UIImageView {
    
    @IBInspectable var color: UIColor = UIColor.white {
        didSet {
            layer.borderColor = color.cgColor
        }
    }
    @IBInspectable var lineWidth: CGFloat = 2.0 {
        didSet {
            layer.borderWidth = lineWidth
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 0.5 * bounds.size.width
        self.contentMode = .scaleAspectFill
        image = image?.getRoundedImage()
        clipsToBounds = true
    }

}
