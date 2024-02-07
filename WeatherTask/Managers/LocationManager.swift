//
//  LocationManager.swift
//  WeatherTask
//
//  Created by Muhammad Amiin Obidhonyi on 2022-11-02.
//

import Foundation
import CoreLocation
import Observation

@Observable
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    private let geocoder = CLGeocoder()
    var location: CLLocationCoordinate2D?
    var address: CLPlacemark?
    var isLoading = false
    
    override init() {
        super.init()
        
        manager.delegate = self
    }
    
    public static var shared = LocationManager()
    
    func requestLocation() {
        isLoading = true
        manager.requestLocation()
    }
    
    func reversedGeocodeLocation(_ location: CLLocation){
        Task {
            let placemarks = try? await geocoder.reverseGeocodeLocation(location)
            address = placemarks?.last
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
        isLoading = false
    }
    
    // This function will be called if we run into an error
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting location", error)
        isLoading = false
    }
}
