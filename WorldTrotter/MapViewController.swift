//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Adminaccount on 10/19/17.
//  Copyright © 2017 Steve Harski. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var mapView: MKMapView!
    var locationManager: CLLocationManager!
    var pinIndex = 0
    
    override func loadView() {
        mapView = MKMapView()
        view = mapView
        
        locationManager = CLLocationManager()
        
        let standartString = NSLocalizedString("Standart", comment: "Standart map view")
        let satelliteString = NSLocalizedString("Satellite", comment: "Satellite map view")
        let hybridString = NSLocalizedString("Hybrid", comment: "Satellite map view")
        
        let segmentedControl = UISegmentedControl(items: [standartString, hybridString, satelliteString])
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.addTarget(self, action: #selector(MapViewController.mapTypeChanged(_:)), for: .valueChanged)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        segmentedControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 8).isActive = true
        let margins = view.layoutMarginsGuide
        segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        
        // Location button
        let locationButton = UIButton(type: .system)
        locationButton.setImage(UIImage(named: "geo_fence")!, for: .normal)
        locationButton.addTarget(self, action: #selector(locateUser(sender:)), for: .touchUpInside)
        
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(locationButton)
        
        locationButton.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -10).isActive = true
        locationButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        
        // Pins button
        let pinsButton = UIButton(type: .system)
        pinsButton.setImage(UIImage(named: "worldwide_location")!, for: .normal)
        pinsButton.addTarget(self, action: #selector(displayNextPin), for: .touchUpInside)
        pinsButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pinsButton)
        
        pinsButton.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -10).isActive = true
        pinsButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
       
        // Add pins
        mapView.addAnnotations(getPins())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func mapTypeChanged(_ segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
    
    
    
    @objc func locateUser(sender: UIButton!) {
        locationManager.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
    }
    
    // Pins
    let locationData = [
        ["name": "Lviv", "latitude": 49.85, "longtitude": 24.01],
        ["name": "New York", "latitude": 40.71, "longtitude": -74.00],
        ["name": "Los Angeles", "latitude": 34.05, "longtitude": -118.24],
    ]
    
    func getPins() -> [MKPointAnnotation] {
        var pins = [MKPointAnnotation]()
        for each in locationData {
            let pin = MKPointAnnotation()
            pin.coordinate = CLLocationCoordinate2DMake(each["latitude"] as! Double, each["longtitude"] as! Double)
            pin.title = each["name"] as? String
            pins.append(pin)
        }
        return pins
    }
    
    
    @objc func displayNextPin() {
        locationManager.requestWhenInUseAuthorization()
        var pins = getPins()
        let region = MKCoordinateRegionMakeWithDistance(pins[pinIndex].coordinate, 500, 500)
        mapView.setRegion(region, animated: true)
        pinIndex += 1
        
        if (pinIndex > (pins.count - 1)) {
            pinIndex = 0
        }
    }

}
