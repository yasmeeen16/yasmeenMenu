//
//  ChoseLocation.swift
//  MenuFoodDelevery
//
//  Created by Atiaf on 12/3/19.
//  Copyright © 2019 Atiaf. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ChoseLocation: UIViewController {

    var userObjectforRegisterationSecondStep: UserDataSentForRegistration?
    let locationManager = CLLocationManager()
    
    
    var LatCurruntLocation: String?
    var LongCurrentLocation: String?
    
    var latSelectedLocation: String?
    var longselectedLocation: String?
    
    
    var phone : String!
    var activation_code : String!
    var device_reg_id : String!
    var name : String!
    var email : String!
    var password : String!
    
    var street:String = ""
    var country:String = ""
    var city:String = ""
    var locationName:String!
    var ZiP:String!
    @IBOutlet weak var MapView: MKMapView!
    @IBOutlet weak var SearchForAddress: UITextField!
    @IBOutlet weak var ShowAddress: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        MapView.showsUserLocation = true
        
        print("opject For Registration =============== \(self.phone!)  \(self.activation_code!)\(self.device_reg_id!) \(self.name!)\(self.email!) \(self.password!)")
        
    }
    
    
    
    @IBAction func SearchPtn(_ sender: Any) {
        
        
        let address = self.SearchForAddress.text ?? ""
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let location = placemarks.first?.location
                else {
                    // handle no location found
                    print("Location not found")
                    return
            }
            
            // Use your location
            print("Location Is ::   \(location.coordinate.longitude)  \(location.coordinate.longitude)")
            self.longselectedLocation = "\(location.coordinate.longitude)"
            self.latSelectedLocation = "\(location.coordinate.latitude)"
            let coordinate = location.coordinate
            
            let mapCamera = MKMapCamera(lookingAtCenter: coordinate, fromDistance: 10000, pitch: 65, heading: 0)
            

            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            //annotation.title = "Store"
            //annotation.subtitle = "Location Of Store"
            self.MapView.removeAnnotations(self.MapView.annotations)
            self.MapView.addAnnotation(annotation)
            self.MapView.addAnnotation(annotation)
            self.MapView.setCamera(mapCamera, animated: true)
        }
        
    }
    
    @IBAction func useCurrentLocation(_ sender: Any) {
        
       
        // Add annotation:
        let annotation = MKPointAnnotation()
        if let lat = Double(self.LatCurruntLocation!) {
            if let lag = Double(self.LongCurrentLocation!){
                annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lag)
                self.latSelectedLocation = "\(lat)"
                self.longselectedLocation = "\(lag)"
                //annotation.title = "Store"
                //annotation.subtitle = "Location Of Store"
                self.MapView.removeAnnotations(MapView.annotations)
                self.MapView.addAnnotation(annotation)
                MapView.addAnnotation(annotation)
            }else{
                print("can not convert lang")
            }
            
        } else {
             print("can not convert lat")
            
        }
        
        
        
        
    }
    
    @IBAction func AddPin(_ sender: UILongPressGestureRecognizer) {
        //it tells me wher i clicking in mapView
        let location = sender.location(in: MapView)
        //take this point and convert to coordinate
        let coordinate = MapView.convert(location,toCoordinateFrom: MapView)
        print("\(coordinate.latitude)   \(coordinate.longitude)")
        self.latSelectedLocation = "\(coordinate.latitude)"
        self.longselectedLocation = "\(coordinate.longitude)"
        latLong(lat: coordinate.latitude, long: coordinate.longitude)
        self.ShowAddress.text = "\(self.street) \(self.city) \(self.country)"
        self.SearchForAddress.text = "\(self.street) \(self.city) \(self.country)"
        // Add annotation:
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        //annotation.title = "Store"
        //annotation.subtitle = "Location Of Store"
        self.MapView.removeAnnotations(MapView.annotations)
        self.MapView.addAnnotation(annotation)
        MapView.addAnnotation(annotation)
        
        
        
        
        
    }
    
    
    @IBAction func confirmLocation(_ sender: Any) {
        
        print("opject For Registration \(self.name!)  \(self.phone!) \(self.email!) \(self.password!) \(self.device_reg_id!)  \(self.activation_code!) \(self.latSelectedLocation!) \(self.longselectedLocation!)")
        RegisterationClient.AddNewuser(name: self.name!, Phone: self.phone!, email: self.email!, password: self.password!, device_reg_id: self.device_reg_id!, activation_code: self.activation_code!, lat: self.latSelectedLocation!, lag: self.longselectedLocation!) { (error, success, result) in
            if success!{
                print("success")
//                print(result?.message!)
//                print(result?.result!)
//                print(result?.token!)
                
            }else{
                print("not succsess")
            }
        }
        self.performSegue(withIdentifier: "thanksSeguey", sender: nil)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationvc = segue.destination as! FinalStepInRegistration

    }
    
}
//setting up the location manager delegate.
extension ChoseLocation: CLLocationManagerDelegate{
    
    

    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse{
            locationManager.requestLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        self.LatCurruntLocation = "\(locValue.latitude)"
        self.LongCurrentLocation = "\(locValue.longitude)"

        guard let location: CLLocation = manager.location else { return }
        fetchCityAndCountry(from: location) { city, country, error in
            guard let city = city, let country = country, error == nil else { return }
            print(city + ", " + country)
        }
        latLong(lat: locValue.latitude, long: locValue.longitude)
        
        //        if let location = locations.first{
//            print("location::   \(location)")
//            let span = MKCoordinateSpan(latitudeDelta: 0.05 , longitudeDelta: 0.05)
//            let region = MKCoordinateRegion(center: location.coordinate, span: span)
//
//            MapView.setRegion(region, animated: true)
//        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error :: \(error)")
    }
    func fetchCityAndCountry(from location: CLLocation, completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            completion(placemarks?.first?.locality,
                       placemarks?.first?.country,
                       error)
        }
    }
    
    func latLong(lat: Double,long: Double)  {
        
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: lat , longitude: long)
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            print("Response GeoLocation : \(placemarks!)")
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            
            // Country
            if let country = placeMark!.addressDictionary!["Country"] as? String {
                print("Country :- \(country)")
                self.country = country
                // City
                if let city = placeMark.addressDictionary!["City"] as? String {
                    print("City :- \(city)")
                    self.city = city
                    // State
                    if let state = placeMark.addressDictionary!["State"] as? String{
                        print("State :- \(state)")
                        // Street
                        if let street = placeMark.addressDictionary!["Street"] as? String{
                            print("Street :- \(street)")
                            let str = street
                            let streetNumber = str.components(
                                separatedBy: NSCharacterSet.decimalDigits.inverted).joined(separator: "")
                            print("streetNumber :- \(streetNumber)" as Any)
                            self.street = street
                            
                            // ZIP
                            if let zip = placeMark.addressDictionary!["ZIP"] as? String{
                                print("ZIP :- \(zip)")
                                
                                // Location name
                                if let locationName = placeMark?.addressDictionary?["Name"] as? String {
                                    print("Location Name :- \(locationName)")
                                    // Street address
                                    if let thoroughfare = placeMark?.addressDictionary!["Thoroughfare"] as? NSString {
                                        print("Thoroughfare :- \(thoroughfare)")
                                        
                                    }
                                }
                            }
                        }
                    }
                }
            }
        })
    }
    
    
    
    
}
