//
//  MapsViewController.swift
//  WooShot
//
//  Created by Mathieu Vandeginste on 12/10/2016.
//  Copyright © 2016 WooShot. All rights reserved.
//

import UIKit
import MapKit

class MapsViewController: UIViewController {
    
    
    var places = [Place]()
    var currentPlace: Place?
    var userLocation: CLLocation?
    var locationManager = CLLocationManager()
    var centerViewOnCurrentPosition = true
    
    @IBOutlet weak var map: MKMapView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    

}

