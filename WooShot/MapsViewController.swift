//
//  MapsViewController.swift
//  WooShot
//
//  Created by Mathieu Vandeginste on 12/10/2016.
//  Copyright © 2016 WooShot. All rights reserved.
//

import UIKit
import MapKit

class MapsViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    
    @IBOutlet weak var map: MKMapView!
    var userLocation: CLLocationCoordinate2D?
    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    func configureView() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
