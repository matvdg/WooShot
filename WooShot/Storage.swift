//
//  Storage.swift
//  WooShot
//
//  Created by Mathieu Vandeginste on 04/12/2016.
//  Copyright © 2016 WooShot. All rights reserved.
//

import Foundation
import FirebaseStorage

class Storage {
    
    // Get a reference to the storage service, using the default Firebase App
    let storageRef = FIRStorage.storage().reference()
    
    func uploadProfilePic(data: Data, callback: @escaping (String?) -> () )  {
        
        guard let id = Provider.getAuth().uid else { return callback("no user authenticated") }
        
        
        let imageRef = storageRef.child("images/\(id).jpg")
        print(imageRef)
        
        
        // Upload the file
        imageRef.put(data, metadata: nil) { metadata, error in
            if let err = error {
                // Uh-oh, an error occurred!
                callback(err.localizedDescription)
            } else {
                callback(nil)
            }
        }
    }
    
    func downloadProfilePic(callback: @escaping (String?, Data?) -> () )  {
        
        guard let id = Provider.getAuth().uid else { return callback("no user authenticated", nil) }
        
        let imageRef = storageRef.child("images/\(id).jpg")
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
