//
//  Storage.swift
//  WooShot
//
//  Created by Mathieu Vandeginste on 04/12/2016.
//  Copyright © 2016 WooShot. All rights reserved.
//

import UIKit
import FirebaseStorage


class FirebaseImageManager: ImageProtocol {
    
    // Get a reference to the storage service, using the default Firebase App
    private let storageRef = FIRStorage.storage().reference()
    
    private let qualityCompression: CGFloat = 1
    
    func upload(image: UIImage, callback: @escaping (String?) -> ()) {
        
        guard let imageData = UIImageJPEGRepresentation(image.getSquaredImage(), qualityCompression) else {
            print("error in file \(#file), line \(#line)")
            return
        }
        self.uploadProfilePic(data: imageData) { (err) in
            if let error = err {
                callback(error)
            } else {
                callback(nil)
            }
        }
    }
    
    func download(callback: @escaping (String?, UIImage?) -> ()) {
        self.downloadProfilePic { (err, data) in
            if let error = err {
                callback(error, nil)
            } else {
                let image = UIImage(data: data!)
                callback(nil, image)
            }
        }
    }
    
    
    
    private func uploadProfilePic(data: Data, callback: @escaping (String?) -> () )  {
        
        let imageRef = storageRef.child("images/\(Provider.getUserManager().uid).jpg")
        print(imageRef)
        
        // Create file metadata including the content type
        let metadata = FIRStorageMetadata()
        metadata.contentType = "image/jpeg"
        
        // Upload the file
        imageRef.put(data, metadata: metadata) { metadata, error in
            if let err = error {
                // Uh-oh, an error occurred!
                callback(err.localizedDescription)
            } else {
                callback(nil)
            }
        }
        
    }
    
    private func downloadProfilePic(callback: @escaping (String?, Data?) -> () )  {
        
        let imageRef = storageRef.child("images/\(Provider.getUserManager().uid).jpg")
        print(imageRef)
        
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        imageRef.data(withMaxSize: 1 * 1024 * 1024) { (data, error) -> Void in
            if let err = error {
                // Uh-oh, an error occurred!
                callback(err.localizedDescription, nil)
            } else {
                // Data for "images/island.jpg" is returned
                callback(nil, data!)
            }
        }
    }
    
    
    
}
