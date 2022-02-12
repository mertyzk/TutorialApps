//
//  ViewController.swift
//  CoreLocation-MapKit
//
//  Created by Macbook Air on 12.02.2022.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    
    var locationManager:CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

        
    }


}

extension ViewController:CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lastPosition:CLLocation = locations[locations.count-1]
        latitudeLabel.text = "Latitude : \(lastPosition.coordinate.latitude)"
        longitudeLabel.text = "Longitude: \(lastPosition.coordinate.longitude)"
        speedLabel.text = "Speed: \(lastPosition.speed)"
        
        let location = CLLocationCoordinate2D(latitude: lastPosition.coordinate.latitude, longitude: lastPosition.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.0075, longitudeDelta: 0.0075)
        let zone = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(zone, animated: true)
        mapView.showsUserLocation = true
        
    }
    
    
}

