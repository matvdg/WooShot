//
//  Place.swift
//  WooShot
//
//  Created by Mathieu Vandeginste on 22/10/2016.
//  Copyright © 2016 WooShot. All rights reserved.
//

import Foundation

class Place {
    
    var displayName: String
    var imageUrl: String
    var lat: Double
    var long: Double
    var phone: String
    var address: String
    var description: String
    var openingHours: String
    
    init(displayName: String, imageUrl: String, lat: Double, long: Double, phone: String, address: String, description: String, openingHours: String){
        self.displayName = displayName
        self.imageUrl = imageUrl
        self.lat = lat
        self.long = long
        self.phone = phone
        self.address = address
        self.description = description
        self.openingHours = openingHours
    }
    
}
