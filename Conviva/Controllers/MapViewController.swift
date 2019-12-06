//
//  MapViewController.swift
//  Conviva
//
//  Created by Joyce Simão Clímaco on 28/11/19.
//  Copyright © 2019 Gabriel Ferreira. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var radiusView: UIImageView!
    @IBOutlet weak var radiusLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var auxView: UIView!
    
    let alert = Alert()
    let locationManager = CLLocationManager()
    let maxSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    
    var isCalledIn: MapCalls = .initialScreen
    var resultSearchController: UISearchController? = nil
    var userLocation: CLLocation? = nil
    
    var longitude: Double = -25.0
    var latitude: Double = -40.0
    var radius: Double = 10000.0
    var address: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.delegate = self
        self.locationManager.delegate = self
        self.checkAuthorizationStatus()
        
        Setup.setupButton(self.nextButton, withText: "Entrar")
        self.radiusView.isUserInteractionEnabled = false
        self.auxView.isUserInteractionEnabled = false
        
        switch self.isCalledIn {
        case .initialScreen:
            Setup.setupButton(self.nextButton, withText: "Entrar")
            radiusView.image = UIImage(named: "pinAndCircle")
            navigationItem.title = "Escolha sua região"
        case .createEvent:
            radiusView.image = UIImage(named: "pin")
            navigationItem.title = "Local da iniciativa"
            Setup.setupButton(self.nextButton, withText: "Avançar")
        case .createProfile:
            navigationItem.title = "Sua região"
            radiusView.image = UIImage(named: "pinAndCircle")
            Setup.setupButton(self.nextButton, withText: "Avançar")
        default:
            Setup.setupButton(self.nextButton, withText: "Avançar")
            radiusView.image = UIImage(named: "pinAndCircle")
        }
        
        // MARK: Adress Search configuration
        
        // CREATES SEARCH CONTROLLER AN m D INSTANTIATES A TABLEVIEWCONTROLLER TO HANDLE THE RESULTS
        // Instantiates the TableViewController that will show the adress results
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTableViewController
        // Instantiates our search controller and displays its results on the TableView instantiated above
        self.resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        // Sets the TableView as the results updater as well
        self.resultSearchController?.searchResultsUpdater = locationSearchTable
        // Sets this ViewController mapView as the results table mapView
        locationSearchTable.mapView = mapView
        
        // CREATES AND CONFIGURES THE SEARCHBAR
        // Make  searchBar from the searchController created above
        let searchBar = self.resultSearchController!.searchBar
        // Defines searchBar appearence
        searchBar.sizeToFit()
        searchBar.placeholder =  "Entre seu endereço..."
        self.navigationItem.searchController =  self.resultSearchController!
        
        // PREVENTS THE TABLEVIEW FROM VANISHING WITH OTHER ELEMENTS
        // Prevents the NavigationBar from being  hidden when  showing the TableView
        self.resultSearchController?.hidesNavigationBarDuringPresentation = false
        // Makes this ViewController the presentation context for the results table, preventing it from overlapping the searchBar
        self.definesPresentationContext = true
        
        // Sets delegate to handle map search with the HandleMapSearch protocol
        locationSearchTable.handleMapSearchDelegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.centerMapOnUserLocation()
    }
    
    @IBAction func nextButton(_ sender: Any) {
        
        getCurrentCircularRegion()
        getAdress(latitude: self.latitude, longitude: self.longitude) { (parsedAddress) in
            
            OperationQueue.main.addOperation {
                
                self.address = parsedAddress
                print(self.address)
                print("latitude: " + String(self.latitude))
                print("longitude: " + String(self.longitude))
                print("radius: " + String(self.radius))
                
                switch self.isCalledIn {
                case .createEvent:
                    self.performSegue(withIdentifier: "mapToCreateEvent", sender: self)
                case .createProfile:
                    self.performSegue(withIdentifier: "mapToProfileRegistration", sender: self)
                default:
                    self.performSegue(withIdentifier: "mapToTabBar", sender: self)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let radius = self.radius < 20000 ? 20000 : self.radius
        
        if segue.identifier == "mapToProfileRegistration" {
            let destination = segue.destination as! RegisterViewController
            destination.address = self.address
            destination.latitude = self.latitude
            destination.longitude = self.longitude
            destination.radius = radius
        }
        else if segue.identifier == "mapToCreateEvent" {
            let destination = segue.destination as! CreateEventViewController
            destination.event.latitude = self.latitude
            destination.event.longitude = self.longitude
            destination.event.address = self.address
            destination.localIniciative.textField.text = self.address
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    
    // Zooms in to a certain map region
    func zoomMapTo(location: CLLocation) {
        let region =  MKCoordinateRegion(center: location.coordinate, span: self.defaultSpan)
        mapView.setRegion(region, animated: true)
    }
    
    // MARK: Defining Radius
    func getCurrentCircularRegion() {
        
        let edge2D: CLLocationCoordinate2D = mapView.convert(CGPoint(x: 0, y: self.radiusView.frame.height / 2), toCoordinateFrom: self.radiusView)
        let center2D: CLLocationCoordinate2D = mapView.convert(CGPoint(x: self.radiusView.frame.width / 2 , y: self.radiusView.frame.height / 2), toCoordinateFrom: self.radiusView)
        
        let edge = CLLocation(latitude: edge2D.latitude, longitude: edge2D.longitude)
        let center = CLLocation(latitude: center2D.latitude, longitude: center2D.longitude)
        
        self.radius = center.distance(from: edge)
        self.latitude = center.coordinate.latitude
        self.longitude = center.coordinate.longitude
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    func getAdress(latitude: Double,longitude: Double, completion: @escaping (String) -> Void) {
        
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: latitude , longitude: longitude)
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            var placemark: CLPlacemark!
            placemark = placemarks?[0]
            
            var addressList: [String?] = []
            addressList.append(placemark.name) // name
            addressList.append(placemark.thoroughfare) // street
            addressList.append(placemark.subThoroughfare) // number
            addressList.append(placemark.subAdministrativeArea) // city
            addressList.append(placemark.administrativeArea) // state
            addressList.append(placemark.country) // country
            
            var parsedAddress: String = ""
            for element in addressList {
                if let adressElement = element {
                    if parsedAddress != "" {
                        parsedAddress = parsedAddress + ", "
                    }
                    parsedAddress = parsedAddress + adressElement
                }
            }
            completion(parsedAddress)
        })
    }
    
    // Checks if Location Services are enabled and if not asks for authorization
    func checkAuthorizationStatus() {
        
        if CLLocationManager.locationServicesEnabled() {
            let status  = CLLocationManager.authorizationStatus()
            
            if status == .authorizedWhenInUse || status == .authorizedAlways {
                locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
                locationManager.startUpdatingLocation()
            }
            else if status == .denied || status == .restricted {
                let alertController = self.alert.presentLocationAlert()
                present(alertController, animated: true, completion: nil)
            }
            else {
                self.locationManager.requestWhenInUseAuthorization()
            }
        }
    }
    
    // Hamdles changes in authorization status
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkAuthorizationStatus()
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            centerMapOnUserLocation()
        }
    }
    
    // Centers map on user current location
    func centerMapOnUserLocation() {
        locationManager.requestLocation()
        
        if let location = locationManager.location {
            self.zoomMapTo(location: location)
        }
    }
    
    // Handles location updates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first {
            self.userLocation = location
        }
        self.locationManager.stopUpdatingLocation()
    }
    
    // Shows error message
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
    }
}

// MARK: HandleMapSearch extension
// Instantiates the protocol to pass address search information
extension MapViewController: HandleMapSearch {
    
    func dropPinZoomIn(placemark: MKPlacemark) {
        
        // Shows corresponding map region
        let region = MKCoordinateRegion(center: placemark.coordinate, span: self.defaultSpan)
        mapView.setRegion(region, animated: true)
    }
}
