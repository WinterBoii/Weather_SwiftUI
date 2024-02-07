//
//  WeatherManager.swift
//  WeatherTask
//
//  Created by Muhammad Amiin Obidhonyi on 2022-11-02.
//  Jönköping: lat: 57.78145, long: 14.15618

import Foundation
import CoreLocation
import Combine

class WeatherManager: ObservableObject {
    @Published var weatherModel: ResponseBody?
    @Published var didFind = false
    
    public static var shared = WeatherManager()
    
    var loc = LocationManager().location
    
    private let geoCode = CLGeocoder()
    var lat = 0.0
    var lon = 0.0
    
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ResponseBody {
        print("\(latitude), \(longitude)")
        guard let url = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&hourly=temperature_2m,relativehumidity_2m,apparent_temperature,weathercode&daily=weathercode,temperature_2m_max,temperature_2m_min&current_weather=true&windspeed_unit=ms&timezone=Europe%2FBerlin") else { fatalError("Missing URL") }
        
        // This function will use the new async await method introduced in 2021
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error fetching weather data") }
        
        let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)
        
        return decodedData
    }
    
    func getLatLonFromCity(cityName: String) {
        geoCode.geocodeAddressString(cityName, completionHandler: { (placemarks, error) in
            if (error != nil) {
                self.didFind = false
                print("Failed to fetch location")
                return
            }
            if let placemarks = placemarks {
                self.lat = placemarks[0].location?.coordinate.latitude ?? 0.0
                self.lon = placemarks[0].location?.coordinate.longitude ?? 0.0
                self.didFind = true
                print(self.lat)
                print(self.lon)
                
                Task {
                    self.weatherModel = try await self.getCurrentWeather(latitude: self.lat, longitude: self.lon)
                }
            }
        })
    }
}


struct ResponseBody: Decodable {
    let latitude, longitude, generationtime_ms: Float
    let utc_offset_seconds: Int
    let timezone, timezone_abbreviation: String
    let elevation: Int
    
    let current_weather: Current_weather
    let daily_units: Daily_units
    let daily: Daily
    let hourly_units: Hourly_Units
    let hourly: Hourly
}

struct Current_weather: Decodable {
    let temperature: Float
    let windspeed: Float
    let winddirection: Int
    let weathercode: Int
    let time: String
}

struct Daily_units: Decodable {
    let temperature_2m_max: String
    let temperature_2m_min: String
    let time: String
    let weathercode: String
}

struct Daily: Decodable {
    let time: [String]
    let weathercode: [Int]
    let temperature_2m_max: [Float]
    let temperature_2m_min: [Float]
}

struct Hourly: Decodable {
    let time: [String]
    let temperature_2m: [Float]
    let relativehumidity_2m: [Int]
    let apparent_temperature: [Float]
    let weathercode: [Int]
}

struct Hourly_Units: Decodable {
    let time, temperature_2m, relativehumidity_2m, apparent_temperature: String
    let weathercode: String
}
