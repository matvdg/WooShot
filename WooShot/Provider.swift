//
//  Provider.swift
//  WooShot
//
//  Created by Mathieu Vandeginste on 21/10/2016.
//  Copyright © 2016 WooShot. All rights reserved.
//

import Foundation

class Provider {
    
    private static let userManager = UserManager()
    private static let imageManager = ImageManager()
    private static let chatManager = ChatManager()
    private static let placeManager = PlaceManager()
    
    static func getUserManager() -> UserManager {
        return self.userManager
    }
    
    static func getImageManager() -> ImageManager {
        return self.imageManager
    }
    
    static func getChatManager() -> ChatManager {
        return self.chatManager
    }
    
    static func getPlaceManager() -> PlaceManager {
        return self.placeManager
    }
    
    
}
