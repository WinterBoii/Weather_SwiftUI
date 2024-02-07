//
//  CityManager.swift
//  WeatherTask
//
//  Created by Muhammad Amiin Obidhonyi on 2022-11-11.
//

import Foundation
import CoreLocation
/*
class CityManager {
    func forwardGeocoding(address: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address, completionHandler: { (placemarks, error) in
            if error != nil {
                print("Failed to retrieve location")
                return
            }
            
            var location: CLLocation?
            
            if let placemarks = placemarks, placemarks.count > 0 {
                location = placemarks.first?.location
            }
            
            if let location = location {
                let coordinate = location.coordinate
                print("\nlat: \(coordinate.latitude), long: \(coordinate.longitude)")
            }
            else
            {
                print("No Matching Location Found")
            }
            
        })
    }
    func reverseGeocoding(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        geocoder.reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            if error != nil {
                print("Failed to retrieve City")
                return
            }
            
            if let placemarks = placemarks, let placemark = placemarks.first {
                print(placemark.locality!)
            }
            else
            {
                print("No Matching City Found")
            }
        })
    }
}

*/
