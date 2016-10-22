//
//  UserManager.swift
//  WooShot
//
//  Created by Mathieu Vandeginste on 21/10/2016.
//  Copyright © 2016 WooShot. All rights reserved.
//

import Foundation


class UserManager {
    
    private var currentUser: User?
    
    func getCurrentUser() -> User? {
        return currentUser
    }
    
    //setters
    func setCurrentUser(displayName: String, isMale: Bool, lovesMen: Bool, lovesWomen: Bool, imageUrl: String) {
        self.currentUser = User(displayName: displayName, imageUrl: imageUrl, isMale: isMale, lovesMale: lovesMen, lovesFemale: lovesWomen)
    }
    
    
    
    func updateDisplayName(displayName: String) {
        if let user = self.currentUser {
            user.displayName = displayName
            print("new name = \(displayName)")
        }
    }
    
    func updatePhoto(imageUrl: String) {
        if let user = self.currentUser {
            user.imageUrl = imageUrl
        }
    }
    
    func updateSex(isMale: Bool) {
        if let user = self.currentUser {
            user.isMale = isMale
        }
    }
    
    func updatePrefMale(lovesMen: Bool) {
        if let user = self.currentUser {
            user.lovesMale = lovesMen
        }
    }
    
    func updatePrefFemale(lovesWomen: Bool) {
        if let user = self.currentUser {
            user.lovesFemale = lovesWomen
        }
    }
}
