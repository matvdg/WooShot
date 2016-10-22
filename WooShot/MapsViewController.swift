//
//  MapsViewController.swift
//  WooShot
//
//  Created by Mathieu Vandeginste on 12/10/2016.
//  Copyright © 2016 WooShot. All rights reserved.
//

import UIKit
import MapKit

class MapsViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UITableViewDataSource {
    
    
    var placeManager = Provider.getPlaceManager()
    var places = [Place]()
    var currentPlace: Place?
    var userLocation: CLLocation?
    var locationManager = CLLocationManager()
    var centerViewOnCurrentPosition = true
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var image: CornerRadiusImageView!
    @IBOutlet weak var checkButton: AppleMusicButton!
    @IBOutlet weak var placeTitleLabel: UILabel!
    
    @IBAction func checkInOut(_ sender: AnyObject) {
        print("checkInOut")
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        displayPlace()
    }
    
    private func displayPlace() {
        places = placeManager.getPlaces()
        currentPlace = places.first
        image.image = UIImage(named: currentPlace!.imageUrl)
        placeTitleLabel.text = currentPlace!.displayName
        self.tableView.separatorColor = UIColor.clear
        configureView()
    }

    func configureView() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        self.map.showsUserLocation = true
        
        for place in places { let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: place.lat, longitude: place.long)
            annotation.title = place.displayName
            annotation.subtitle = "\(place.description)\n\(place.openingHours)\(place.phone)\(place.address)"
            map.addAnnotation(annotation)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last! as CLLocation
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.userLocation = location
        if centerViewOnCurrentPosition {
            self.map.setRegion(region, animated: true)
            centerViewOnCurrentPosition = false
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        //overriding view for annotation
        if (annotation is MKUserLocation) { return nil }
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detail", for: indexPath)
        cell.textLabel!.textColor = UIColor.white
        cell.textLabel!.adjustsFontSizeToFitWidth = true
        cell.imageView?.image = nil
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = currentPlace?.description
        case 1:
            cell.textLabel?.text = currentPlace?.openingHours
        case 2:
            cell.textLabel?.text = currentPlace?.phone
        case 3:
            cell.textLabel?.text = currentPlace?.address
        default:
            break
        }
        return cell
        
        
    }

    
    

}

