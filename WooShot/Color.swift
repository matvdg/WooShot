//
//  Color.swift
//  WooShot
//
//  Created by Mathieu Vandeginste on 09/09/2016.
//  Copyright © 2016 WooShot. All rights reserved.
//

import UIKit

class Color {
    
    //p500 #E91E63
    static let wooColor = UIColor(netHex: 0xE91E63)
    //a700 #C51162
    static let wooColorDark = UIColor(netHex: 0xC51162)
    static let a200 = UIColor(netHex: 0xFF4081)
    static let p600 = UIColor(netHex: 0xD81B60)
    static let p50 = UIColor(netHex: 0xFCE4EC)
    static let p800 = UIColor(netHex: 0xAD1457)
    static let p800t = UIColor(hex: 0xAD1457, alpha: 0.54)
    
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


extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(red: Int, green: Int, blue: Int, opacity: CGFloat) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: opacity)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
    
    convenience init(hex:Int, alpha: CGFloat) {
        self.init(red:(hex >> 16) & 0xff, green:(hex >> 8) & 0xff, blue:hex & 0xff, opacity: alpha)
    }
}
