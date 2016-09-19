//
//  Color.swift
//  WooShot
//
//  Created by Mathieu Vandeginste on 09/09/2016.
//  Copyright © 2016 WooShot. All rights reserved.
//

import UIKit

class Color {
    
    static let wooColor = UIColor(red: 233/255, green: 30/255, blue: 99/255, alpha: 1.0)
    
    static let wooColorDark = UIColor(red: 197/255, green: 17/255, blue: 98/255, alpha: 1.0)
    
    static func getGradient(view: UIView) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [Color.wooColorDark.cgColor,Color.wooColor.cgColor]
        gradientLayer.locations = [0, 1]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        return gradientLayer
    }
    
}
