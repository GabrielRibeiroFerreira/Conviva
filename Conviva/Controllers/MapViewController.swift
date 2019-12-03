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
    
    let locationManager = CLLocationManager()
    let maxSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    
    var resultSearchController: UISearchController? = nil
    var userLocation: CLLocation? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.delegate = self
        self.locationManager.delegate = self
        self.checkAuthorizationStatus()
        
        Setup.setupButton(self.nextButton, withText: "Entrar")
        self.radiusView.isUserInteractionEnabled = false
        self.auxView.isUserInteractionEnabled = false
        
        
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
        // Sets recults table background transparency
        // self.resultSearchController?.dimsBackgroundDuringPresentation = true
        // Makes this ViewController the presentation context for the results table, preventing it from overlapping the searchBar
        self.definesPresentationContext = true
        
        // Sets delegate to handle map search with the HandleMapSearch protocol
        locationSearchTable.handleMapSearchDelegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.centerMapOnUserLocation()
    }
    
    func presentAlert() {
        let alertController = UIAlertController (title: "Localização", message: "Seus serviços de localização encontram-se desativados para esse app. Utilizamos  esse serviço para facilitar o encontro da sua região, porém você pode também digitar o endereço desejado. Se desejar, você pode habilitar esse serviço nas suas Configurações.", preferredStyle: .alert)
            
        // Adds settings button action
        let settingsAction = UIAlertAction(title: "Configurações", style: .default) { (_) -> Void in
                
            // Gets the URL for this app's Settings
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            // Opens URL when clicking the button
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (sucess) in
                    print("Settings opened: \(sucess)") // Prints true
                })
            }
        }
        
        // Adds Cancel button action
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        
        // Presents Alert
        present(alertController, animated: true, completion: nil)
    }

}

extension MapViewController: MKMapViewDelegate {
    
    // Zooms in to a certain map region
    func zoomMapTo(location: CLLocation) {
        let region =  MKCoordinateRegion(center: location.coordinate, span: self.defaultSpan)
        mapView.setRegion(region, animated: true)
    }
    
    // This function is called everytime map region is changed by user interaction
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        
        var radius = self.getCurrentCircularRegion().radius
        if radius >= 1000 {
            radius = Double(round(10 * radius) / 1000)
            radiusLabel.text = "\(Int(radius))km"
        } else {
            radiusLabel.text = "\(Int(radius))m"
        }
        
        // Does not allow a bigger region span than the maximum value allowed
        if animated == false {
            if self.mapView.region.span.latitudeDelta > self.maxSpan.latitudeDelta || mapView.region.span.longitudeDelta > self.maxSpan.longitudeDelta {
                let region =  MKCoordinateRegion(center: mapView.region.center, span: self.maxSpan)
                self.mapView.setRegion(region, animated: true)
            }
        }
    }
    
    // MARK: Defining Radius
    func getCurrentCircularRegion() -> MKCircle {
        
        let edge2D: CLLocationCoordinate2D = mapView.convert(CGPoint(x: 0, y: self.radiusView.frame.height / 2), toCoordinateFrom: self.radiusView)
        let center2D: CLLocationCoordinate2D = mapView.convert(CGPoint(x: self.radiusView.frame.width / 2 , y: self.radiusView.frame.height / 2), toCoordinateFrom: self.radiusView)
        
        let edge = CLLocation(latitude: edge2D.latitude, longitude: edge2D.longitude)
        let center = CLLocation(latitude: center2D.latitude, longitude: center2D.longitude)
        
        let distance: Double = center.distance(from: edge)
        return MKCircle(center: center.coordinate, radius: distance)
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    // Checks if Location Services are enabled and if not asks for authorization
    func checkAuthorizationStatus() {
        
        if CLLocationManager.locationServicesEnabled() {
            let status  = CLLocationManager.authorizationStatus()
            
            if status == .authorizedWhenInUse || status == .authorizedAlways {
                locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
                locationManager.startUpdatingLocation()
            }
            else if status == .denied || status == .restricted {
                self.presentAlert()
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
