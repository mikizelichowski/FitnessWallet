//
//  MapViewController.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 11/02/2021.
//

import UIKit
import MapKit

final class MapViewController: UIViewController {
    
    private let mapView = MKMapView()
    
    // create location
    private let locationManager = LocationHandler.shared.locationManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
