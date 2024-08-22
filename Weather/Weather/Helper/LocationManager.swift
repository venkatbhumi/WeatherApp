//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Anil on 2023
//

import Foundation
import CoreLocation

public class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    public let manager = CLLocationManager()
    public var presentLocation: CLLocation?
    
    public override init() {
        super.init()
        manager.delegate = self
        manager.requestAlwaysAuthorization()
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    public func requestLocation() {
        manager.requestLocation()

    }
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty {
            presentLocation = locations.first!
            manager.stopUpdatingLocation()
            requestWeatherForLocation()
        }

    }
    
    public func requestWeatherForLocation() {
        guard let presentLocation = presentLocation else {
            return
        }
        
        let latitude = presentLocation.coordinate.latitude
        let longitude = presentLocation.coordinate.longitude
        print("Latitude:\(latitude) Longitude: \(longitude)")
    }

    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
    }
}
