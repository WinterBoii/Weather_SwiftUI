//
//  WeatherView.swift
//  WeatherTask
//
//  Created by Muhammad Amiin Obidhonyi on 2022-11-03.
//  to READ: https://mhorga.org/2015/08/14/geocoding-in-ios.html

import SwiftUI
import CoreLocation


struct WeatherView: View {
    @StateObject var locationManager = LocationManager.shared
    @StateObject var weatherManager = WeatherManager()
    @State private var formatter = Formatter()
    @State var weather: ResponseBody
    
    @State private var cityInput = ""
    @State private var city = "Jönköping"
    @State var isHere = false
    var selectCity: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .leading)
            {
                VStack {
                    HStack {
                        VStack(alignment: .leading, spacing:  5) {
                            
                            
                            
                            Text("\(city)")
                                .bold().font(.title)
                            
                            Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                                .fontWeight(.light)
                        }
                        
                        Spacer()
                        
                        Section {
                            NavigationLink(destination: SearchCityView()) {
                                VStack() {
                                    Image(systemName: "magnifyingglass")
                                        .font(.title)
                                    Text("Search")
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    
                    VStack {
                        Spacer()
                            .frame(maxWidth: 30, maxHeight: 10)
                        
                        Image(systemName: formatter.weatherCode(code: weatherManager.weatherModel?.current_weather.weathercode ?? 1))
                            .font(.system(size: 65))
                        
                        
                        Text("\(weatherManager.weatherModel?.current_weather.temperature.roundDouble() ?? "")" + "°C")
                            .font(.system(size: 70))
                            .fontWeight(.bold)
                            .padding()
                        
                        
                        Spacer()
                            .frame(height: 100)
                        
                        AsyncImage(url: URL(string: "https://cdn.pixabay.com/photo/2020/01/24/21/33/city-4791269_960_720.png")) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 350)
                        } placeholder: {
                            ProgressView()
                        }
                        
                        HStack {
                            Text("Lat: \(weatherManager.lat)")
                            Text("Lon: \(weatherManager.lon)")
                        }
                        
                        Spacer()
                        
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack {
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Hourly")
                            .bold().padding(.bottom)
                            .padding(.horizontal)
                            .font(.title2)
                        
                        
                        ScrollView(.horizontal) {
                            HStack {
                                let startIndex = indexOfCurrentHour() 
                                let endIndex = min(startIndex + 24, weather.hourly.time.count)
                                let range = startIndex..<endIndex

                                ForEach(range, id: \.self) { hour in
                                    VStack {
                                        Text(formatter.convertDateFormatToHour(inputDate: weatherManager.weatherModel?.hourly.time[hour] ?? weather.hourly.time[hour]))
                                        Text("\(Image(systemName: "umbrella.percent")) \(weatherManager.weatherModel?.hourly.weathercode[hour] ?? 1)%")
                                            .font(.title3)
                                            .padding()
                                        Text("\(weatherManager.weatherModel?.hourly.temperature_2m[hour].roundDouble() ?? "")°C")
                                    }
                                }
                            }
                        }
                        .cornerRadius(15)
                        .padding(.horizontal)
                        
                        Spacer()
                        
                        Text("Daily Forecast")
                            .bold().padding(.bottom)
                            .padding(.horizontal)
                            .font(.title2)
                        
                        ScrollView() {
                            
                            ForEach(0..<7) { day in
                                ScrollView(.horizontal) {
                                    VStack {
                                        
                                        HStack {
                                            Text(formatter.convertDateFormat(inputDate: weatherManager.weatherModel?.daily.time[day] ?? weather.daily.time[day]))
                                                .font(.system(size: 24))
                                                .frame(width: 70)
                                            
                                            Spacer().frame(width: 40)
                                            
                                            WeatherRow(logo: "", name: "Min Temp", value: "\(weatherManager.weatherModel?.daily.temperature_2m_min[day] ?? 0)") 
                            
                                            Spacer().frame(width: 30)
                                            
                                            WeatherRow(logo: "", name: "Max Temp", value: "\(weatherManager.weatherModel?.daily.temperature_2m_max[day] ?? 0)")
                                                
                                            
                                            Spacer().frame(width: 30)
                                            
                                            Image(systemName: formatter.weatherCode(code: weatherManager.weatherModel?.daily.weathercode[day] ?? 1))
                                                .font(.system(size: 30))
                                            
                                            
                                        }
                                        
                                    }
                                    .padding(.bottom)
                                }
                            }
                        }
                        .cornerRadius(15)
                        .frame(maxWidth: .infinity)
                        .padding()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(maxHeight: 440, alignment: .top)
                    .padding()
                    .background(Color(hue: 0.746, saturation: 0.488, brightness: 0.452).opacity(0.6).shadow(.inner(radius: 50)))
                    .cornerRadius(35, corners: [.topLeft, .topRight])
                }
                
            }
            .edgesIgnoringSafeArea(.bottom)
            .background(.linearGradient(colors: [.teal, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
            .preferredColorScheme(.dark)
        }
        .foregroundColor(.white)
        .onAppear {
            weatherManager.getLatLonFromCity(cityName: "Jönköping")
        }
        
    }
    
    func doesExist(inputCity: String, listToSearch: [CityName]) -> Bool {
        
        for task in listToSearch {
            if inputCity == task.name {
                return true
            }
        }
        return false
    }
    
    // Function to get the next 24 hours from the current time
    func next24Hours() -> [String] {
        let hourArray = weather.hourly.time
        let currentDate = weather.current_weather.time
        // Formatter for parsing the hour from the date string
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        
        // Find the index of the current hour in the array
        if let currentIndex = hourArray.firstIndex(of: currentDate) {
            // Display the next 24 hours starting from the current index
            let endIndex = min(currentIndex + 24, hourArray.count)
            let next24Hours = Array(hourArray[currentIndex..<endIndex])
            return next24Hours
        } else {
            return ["nothing"]
        }
    }

    // Function to get the index of the current hour for the next 24 hours
    func indexOfCurrentHour() -> Int {
        let hourArray = weather.hourly.time
        let currentDate = weather.current_weather.time
        // Formatter for parsing the hour from the date string
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH"
        
        // Find the index of the current hour in the array
        if let currentIndex = hourArray.firstIndex(of: currentDate) {
            return currentIndex
        } else {
            return 0
        }
    }

    
}

struct WeatherView_Previews: PreviewProvider {
    @State static var favList = [CityName(name: "Stockholm", isFavorite: true),CityName(name: "Stockholm", isFavorite: true)]
    
    static var previews: some View {
        NavigationStack {
            WeatherView(weather: previewWeather)
        }
    }
}
