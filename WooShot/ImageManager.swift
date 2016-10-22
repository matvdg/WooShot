//
//  ImageManager.swift
//  WooShot
//
//  Created by Mathieu Vandeginste on 21/10/2016.
//  Copyright © 2016 WooShot. All rights reserved.
//


import UIKit

class ImageManager {
    
    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
	
    
    func saveImage(imageUrl: String, image: UIImage){
        let imagePath = path + "/images/"
        try? FileManager.default.createDirectory(atPath: imagePath, withIntermediateDirectories: false, attributes: nil)
        let data = UIImagePNGRepresentation(image)
        FileManager.default.createFile(atPath: imagePath + imageUrl, contents: data, attributes: nil)
    }
    
    func loadImage(imageUrl: String) -> UIImage? {
        let imagePath = path + "/images/" + imageUrl
        let data = FileManager.default.contents(atPath: imagePath)
        guard let imageData = data else {
            print("couldn't load data at this path: \(imagePath)")
            return nil
        }
        let image = UIImage(data: imageData)
        guard let imageLoaded = image else {
            print("couldn't cast data into image")
            return nil
        }
        return imageLoaded
    }

	
	func removeFile(imageUrl: String){
		
		let imagePath = path + "/images/" + imageUrl
		do {
            try FileManager.default.removeItem(atPath: imagePath)
        } catch {
            print("couldn't delete the file \(imagePath)")
        }
		
	}
    
    
}
