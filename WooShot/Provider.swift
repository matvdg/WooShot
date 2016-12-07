//
//  Provider.swift
//  WooShot
//
//  Created by Mathieu Vandeginste on 21/10/2016.
//  Copyright © 2016 WooShot. All rights reserved.
//

import Foundation

class Provider {
    
    // Implementation of protocols, mockable
    private static let userManager = FirebaseUserManager()
    private static let imageManager = FirebaseImageManager()

    
    static func getUserManager() -> UserProtocol {
        return self.userManager
    }
    
    static func getImageManager() -> ImageProtocol {
        return self.imageManager
    }
    
    
}
