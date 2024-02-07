//
//  WeatherView.swift
//  WeatherTask
//
//  Created by Muhammad Amiin Obidhonyi on 2022-11-03.
//

import SwiftUI

struct WeatherView: View {
    //@EnvironmentObject var locationManager: LocationManager
    @EnvironmentObject private var weatherModel: WeatherManager
    @State private var formatter = Formatter()
    var weather: ResponseBody
    var weathercode = 0
    @State var locationManager = LocationManager()
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .leading)
            {
                VStack {
                    HStack {
                        VStack(alignment: .leading, spacing:  5) {
                            
                            Text("Jönköping")
                                .bold().font(.title)
                            
                            Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                                .fontWeight(.light)
                        }
                        
                        Spacer()
                        
                        VStack {
                            
                            NavigationLink(destination: WeatherWeekView(weather: previewWeather)) {
                                
                                Text("Daily ➢")
                                    .fontWeight(.light)
                                    .foregroundColor(.white)
                            }
                        }
                        .font(.system(size: 30))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    
                    VStack {
                        Spacer()
                            .frame(maxWidth: 30, maxHeight: 30)
                        
                        Image(systemName: formatter.weatherCode(code: weather.current_weather.weathercode))
                            .font(.system(size: 75))
                        

                        Text("\(weather.current_weather.temperature.roundDouble())" + weather.daily_units.temperature_2m_min)
                            .font(.system(size: 90))
                            .fontWeight(.bold)
                            .padding()
                        
                        
                        Spacer()
                            .frame(height: 30)
                        
                        AsyncImage(url: URL(string: "https://cdn.pixabay.com/photo/2020/01/24/21/33/city-4791269_960_720.png")) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 380)
                        } placeholder: {
                            ProgressView()
                        }
                        
                        HStack {
                            Text("Lat: \(weather.latitude)")
                            Text("Lon: \(weather.longitude)")
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
                        Text("Weather now")
                            .bold().padding(.bottom)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal) {
                            HStack {
                                WeatherRow(logo: "thermometer.low", name: "Min Temp", value: "\(weather.daily.temperature_2m_min[0])" + "\(weather.daily_units.temperature_2m_min)")
                                
                                Spacer()
                                
                                WeatherRow(logo: "thermometer.high", name: "Max Temp", value: "\(weather.daily.temperature_2m_max[0])" + "\(weather.daily_units.temperature_2m_max)")
                                
                                Spacer()
                                
                                WeatherRow(logo: "wind", name: "Wind", value: weather.current_weather.windspeed.description + " m/s")
                            }
                        }
                        .cornerRadius(15)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .padding(.bottom)
                    .background(Color(hue: 0.746, saturation: 0.488, brightness: 0.452).opacity(0.6))
                    .cornerRadius(35, corners: [.topLeft, .topRight])
                }
                
                
            }
            .edgesIgnoringSafeArea(.bottom)
            .background(.linearGradient(colors: [.teal, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
            .preferredColorScheme(.dark)
        }
        .foregroundColor(.white)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            WeatherView(weather: previewWeather)
        }
    }
}
