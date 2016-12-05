//
//  User.swift
//  WooShot
//
//  Created by Mathieu Vandeginste on 10/10/2016.
//  Copyright © 2016 WooShot. All rights reserved.
//

import Foundation

class User {
    
    var displayName: String
    var isMale: Bool
    var lovesMale: Bool
    var lovesFemale: Bool
    
    init(displayName: String, isMale: Bool, lovesMale: Bool, lovesFemale: Bool){
        self.displayName = displayName
        self.isMale = isMale
        self.lovesFemale = lovesFemale
        self.lovesMale = lovesMale
    }
    
    convenience init(displayName: String){
        self.init(displayName: displayName, isMale: true, lovesMale: false, lovesFemale: true)
    }
}
