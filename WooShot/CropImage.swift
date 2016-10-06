//
//  CropImage.swift
//  WooShot
//
//  Created by Mathieu Vandeginste on 06/10/2016.
//  Copyright © 2016 WooShot. All rights reserved.
//

import UIKit


extension UIImage
{
    
    func getRoundedImage() -> UIImage {
        let imageView: UIImageView = UIImageView(image: self.cropToSquare().resizeImage())
        var layer: CALayer = CALayer()
        layer = imageView.layer
        layer.masksToBounds = true
        layer.cornerRadius = imageView.image!.size.height/2
        UIGraphicsBeginImageContext(imageView.bounds.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return roundedImage!
    }
    
    func cropToSquare() -> UIImage {
        
        let contextImage: UIImage = UIImage(cgImage: self.cgImage!)
        
        let contextSize: CGSize = contextImage.size
        
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        var cgwidth: CGFloat = 480
        var cgheight: CGFloat = 480
        
        // See what size is longer and create the center off of that
        if contextSize.width > contextSize.height { //landscape
            posX = ((contextSize.width - contextSize.height) / 2)
            posY = 0
            cgwidth = contextSize.height
            cgheight = contextSize.height
        } else { //portrait
            posX = 0
            posY = ((contextSize.height - contextSize.width) / 2)
            cgwidth = contextSize.width
            cgheight = contextSize.width
        }
        
        let rect = CGRect(x: posX, y: posY, width: cgwidth, height: cgheight)
        
        // Create bitmap image from context using the rect
        let imageRef = contextImage.cgImage!.cropping(to: rect)!
        
        // Return a new image based on the imageRef and rotate back to the original orientation
        return UIImage(cgImage: imageRef, scale: self.scale, orientation: self.imageOrientation)
        
    }
    
    func resizeImage() -> UIImage {
        let newWidth: CGFloat = 480
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
}



