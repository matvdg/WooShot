//
//  PlaceManager.swift
//  WooShot
//
//  Created by Mathieu Vandeginste on 22/10/2016.
//  Copyright © 2016 WooShot. All rights reserved.
//

import Foundation

class PlaceManager {
 
    private var currentPlace: Place?
    
    func getCurrentPlace() -> Place? {
        return currentPlace
    }
    
    func setCurrentPlace(currentPlace: Place) {
        self.currentPlace = currentPlace
    }
    
    
    //mock
    func getPlaces() -> [Place] {
        let places = [
            Place(displayName: "La Dune", imageUrl: "dune", lat: 43.652185, long: 1.420691, phone: "05 62 75 11 75", address: "Parc de Sesquières, 22 Allées des foulques, 31200 Toulouse", description: "Live Club", openingHours: "tous les jours dès 22h"),
            Place(displayName: "Esmeralda", imageUrl: "esmeralda", lat: 43.651828, long: 1.421152, phone: "05 61 37 14 14", address: "Lac de Sesquières, 31200 Toulouse", description: "ambiance garantie !", openingHours: "ouvre à 23h sauf le lundi"),
            Place(displayName: "La Voile Blanche", imageUrl: "voile", lat: 43.651106, long: 1.420455, phone: "05 62 57 81 39", address: "Parc de Sesquières, 26 Allée des Foulques, 31200 Toulouse", description: "coktails & piscine", openingHours: "tous les jours dès 19h")
        ]
        return places
    }
    
    
    
}
