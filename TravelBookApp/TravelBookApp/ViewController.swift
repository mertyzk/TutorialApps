//
//  ViewController.swift
//  TravelBookApp
//
//  Created by Macbook Air on 17.02.2022.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var commentText: UITextField!
    @IBOutlet weak var saveButtonOutlet: UIButton!
    
    
    var locationManager:CLLocationManager = CLLocationManager()
    
    var choosenLatitude = Double()
    var choosenLongitude = Double()
    
    var selectedTitle = ""
    var selectedTitleID : UUID?
    
    var annotationTitle = ""
    var annotationSubtitle = ""
    var annotationLatitude = Double()
    var annotationLongitude = Double()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecognizer:)))
        
        mapView.addGestureRecognizer(gestureRecognizer)
        gestureRecognizer.minimumPressDuration = 2
        
        let keyboardRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(keyboardRecognizer)
        
        getAll()
        
    }
    
    @IBAction func saveButton(_ sender: Any) {
        let appDeletage = UIApplication.shared.delegate as! AppDelegate
        let context = appDeletage.persistentContainer.viewContext
        
        let newPlace = NSEntityDescription.insertNewObject(forEntityName: "Places", into: context)
        newPlace.setValue(nameText.text, forKey: "title")
        newPlace.setValue(commentText.text, forKey: "subtitle")
        newPlace.setValue(choosenLatitude, forKey: "latitude")
        newPlace.setValue(choosenLongitude, forKey: "longitude")
        newPlace.setValue(UUID(), forKey: "id")
        
        do {
            try context.save()
            print("Success")
        } catch {
            print(error.localizedDescription)
        }
        navigationController?.popToRootViewController(animated: true)
    }
    
}
extension ViewController:MKMapViewDelegate,CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if selectedTitle == ""{
            let lastPosition:CLLocation = locations[locations.count-1]
            let location = CLLocationCoordinate2D(latitude: lastPosition.coordinate.latitude, longitude: lastPosition.coordinate.longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let region = MKCoordinateRegion(center: location, span: span)
            mapView.setRegion(region, animated: true)
            //mapView.showsUserLocation = true
        }

    }
    
    @objc func chooseLocation(gestureRecognizer:UILongPressGestureRecognizer){
        
        if gestureRecognizer.state == .began{
            let touchPoint = gestureRecognizer.location(in: self.mapView)
            let touchedCoordinates = self.mapView.convert(touchPoint, toCoordinateFrom: self.mapView)
            choosenLatitude = touchedCoordinates.latitude
            choosenLongitude = touchedCoordinates.longitude
            let pin = MKPointAnnotation()
            pin.coordinate = touchedCoordinates
            pin.title = nameText.text
            pin.subtitle = commentText.text
            self.mapView.addAnnotation(pin)
        }
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? { // Annotation (pin) ??zelle??tirme
        
        if annotation is MKUserLocation{ // mettoda verilen annotation -- // MKUserLocation kullan??c??n??n yerini g??steren annotation
            return nil // kullan??c??n??n yerini g??stermek istemiyoruz
        }
        let reuseId = "myPin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView // pinView dedi??imiz asl??nda yeni annotation(pin) ve bunu return ediyoruz (KKAnnotationView return'u ister)
        
        if pinView == nil { // pinView olu??turulmad??ysa ba??la
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId) // reuseId ??nemli de??il
            pinView?.canShowCallout = true // bir baloncukla birlikte ekstra bilgi g??sterilen yer (pin ??st??nde)
            pinView?.tintColor = UIColor.green // pindeki bilgi kutucu??unun rengi
            pinView?.pinTintColor = UIColor.orange // annotationlar??n ????kt?????? renk
            
            let button = UIButton(type: UIButton.ButtonType.detailDisclosure) // bilgi yerindeki (canShowCallout) buton olacak
            pinView?.rightCalloutAccessoryView = button // sa?? taraf??nda g??sterilecek
        }
        else{
            pinView?.annotation = annotation // e??er pinview daha ??nceden olu??turulduysa
        }
        return pinView
    }
    
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
    func getAll(){
        if selectedTitle != ""{
            //core data
            
            let appDeletage = UIApplication.shared.delegate as! AppDelegate
            let context = appDeletage.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Places")
            let idString = selectedTitleID!.uuidString
            fetchRequest.predicate = NSPredicate(format: "id = %@", idString)
            fetchRequest.returnsObjectsAsFaults = false
            do{
                let results = try context.fetch(fetchRequest)
                if results.count > 0{
                    
                    for result in results as! [NSManagedObject]{
                        if let title = result.value(forKey: "title") as? String{
                            annotationTitle = title
                        }
                        
                        if let subtitle = result.value(forKey: "subtitle") as? String{
                            annotationSubtitle = subtitle
                        }
                        
                        if let latitude = result.value(forKey: "latitude") as? Double{
                            annotationLatitude = latitude
                        }
                        
                        if let longitude = result.value(forKey: "longitude") as? Double{
                            annotationLongitude = longitude
                        }
                        
                        let annotation = MKPointAnnotation()
                        annotation.title = annotationTitle
                        annotation.subtitle = annotationSubtitle
                        let coordinate = CLLocationCoordinate2D(latitude: annotationLatitude, longitude: annotationLongitude)
                        annotation.coordinate = coordinate
                        mapView.addAnnotation(annotation)
                        nameText.text = annotationTitle
                        commentText.text = annotationSubtitle
                        
                        locationManager.stopUpdatingLocation()
                        
                        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                        let region = MKCoordinateRegion(center: coordinate, span: span)
                        mapView.setRegion(region, animated: true)
                    }
                }
            }catch{
                print(error.localizedDescription)
            }
            saveButtonOutlet.isHidden = true
        }else{
            saveButtonOutlet.isHidden = false
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if selectedTitle != ""{
           
            let requestLoc = CLLocation(latitude: annotationLatitude, longitude: annotationLongitude)
            CLGeocoder().reverseGeocodeLocation(requestLoc) { placemarks, error in
                
                if let placemark = placemarks{
                    if placemark.count > 0 {
                        let newPlacemark = MKPlacemark(placemark: placemark[0]) // a??a????daki map itemi olu??turmak i??in placemark gerekmektedir. ??stteki reverseGeocodeLocation metoduyla bu objeyi al??yoruz.
                        let item = MKMapItem(placemark: newPlacemark) // navigasyonu a??abilmek i??in mapitem olu??turmam??z gerekiyor
                        item.name = self.annotationTitle
                        let launchOptions = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving] // bu map item'??n i??erisinde hangi modda a??aca????m??z?? kararla??t??rd??k. ??rne??in driving
                        item.openInMaps(launchOptions: launchOptions)
                    }
                }
                

                
                
                
            }
            
        }
    }
    
    
}
