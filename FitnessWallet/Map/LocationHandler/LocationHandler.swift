//
//  LocationHandler.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 11/02/2021.
//

import CoreLocation

final class LocationHandler: NSObject, CLLocationManagerDelegate {
    static let  shared = LocationHandler()
    var locationManager: CLLocationManager!
    var location: CLLocation?
    
    override init() {
        super.init()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestAlwaysAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("DEBUG: Location is \(self.locationManager?.location)")
    }
}
