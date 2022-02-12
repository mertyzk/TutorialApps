//
//  ViewController.swift
//  SearchOnTheMap
//
//  Created by Macbook Air on 12.02.2022.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mapView: MKMapView!
    
    let request = MKLocalSearch.Request()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        mapView.delegate = self
        let location = CLLocationCoordinate2D(latitude: 39.92074, longitude: 32.85409)
        let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
        let zone = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(zone, animated: true)
        
        request.region = mapView.region
        
        
        
    }
}
extension ViewController:UISearchBarDelegate,MKMapViewDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        request.naturalLanguageQuery = searchBar.text!
        
        if mapView.annotations.count>0{
            mapView.removeAnnotations(mapView.annotations)
        }
        
        let search = MKLocalSearch(request: request)
        search.start(completionHandler: {(response, error) in
            if error != nil{
                
            }else if response!.mapItems.count == 0{
                print("location null")
            }else{
                for loc in response!.mapItems{
                    if let name = loc.name, let tel = loc.phoneNumber{
                        print("name : \(name)")
                        print("tel:  \(tel)")
                        print("Latitude: \(loc.placemark.coordinate.latitude)")
                        print("Longitude: \(loc.placemark.coordinate.longitude)")
                        
                        let pin = MKPointAnnotation()
                        pin.coordinate = loc.placemark.coordinate
                        pin.title = name
                        pin.subtitle = tel
                        self.mapView.addAnnotation(pin)
                    }
                }
            }
            
            
        })
    }
    
}
