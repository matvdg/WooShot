//
//  ImageManager.swift
//  WooShot
//
//  Created by Mathieu Vandeginste on 05/12/2016.
//  Copyright © 2016 WooShot. All rights reserved.
//

import UIKit

class ImageManager {
    
    let qualityCompression: CGFloat = 1
   
    func upload(image: UIImage, callback: @escaping (String?) -> ()) {
        
        guard let imageData = UIImageJPEGRepresentation(image.getSquaredImage(), qualityCompression) else {
            print("error in file \(#file), line \(#line)")
            return
        }
        Provider.getStorage().uploadProfilePic(data: imageData) { (err) in
            if let error = err {
                callback(error)
            } else {
                callback(nil)
            }
        }
    }
    
    func download(callback: @escaping (String?, UIImage?) -> ()) {
        Provider.getStorage().downloadProfilePic { (err, data) in
            if let error = err {
                callback(error, nil)
            } else {
                let image = UIImage(data: data!)
                callback(nil, image)
            }
        }
    }
}
