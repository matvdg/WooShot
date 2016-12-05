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
    private static let chatManager = ChatManager()
    private static let placeManager = PlaceManager()
    private static let imageManager = ImageManager()
    private static let auth = Auth()
    private static let storage = Storage()

    
    static func getUserManager() -> UserManager {
        return self.userManager
    }
    
    static func getChatManager() -> ChatManager {
        return self.chatManager
    }
    
    static func getPlaceManager() -> PlaceManager {
        return self.placeManager
    }
    
    static func getImageManager() -> ImageManager {
        return self.imageManager
    }
    
    static func getAuth() -> Auth {
        return self.auth
    }
    
    static func getStorage() -> Storage {
        return self.storage
    }
    
    
}
