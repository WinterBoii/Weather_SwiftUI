//
//  FavouriteCityView.swift
//  WeatherTask
//
//  Created by Muhammad Amiin Obidhonyi on 2022-11-30.
//

import SwiftUI

struct FavouriteCityView: View {
    @StateObject var weatherManager: WeatherManager
    var selectCity: String
    
    var body: some View {
        
        VStack(alignment: .leading)
        {
            HStack {
                VStack(alignment: .leading, spacing:  5) {
                    
                    Text("\(selectCity)")
                        .bold().font(.largeTitle)
  
                    Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                }
                .padding()
                
                Spacer()
           
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            VStack {
                Spacer()
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Daily Forecast")
                        .bold().padding(.bottom)
                        .padding(.horizontal)
                        .font(.title2)
                    
                    ScrollView() {
                        
                        ForEach(0..<7) { day in
                            ScrollView(.horizontal) {
                                VStack {
                                    HStack {
                                        Text("\(Date().addingTimeInterval(TimeInterval(60*60*24*day)).formatted(.dateTime.weekday()))")
                                            .font(.system(size: 30))
                                            .frame(width: 70)
                                        
                                        Spacer().frame(minWidth: 70)
                                        
                                        WeatherRow(logo: "", name: "Min Temp", value: "\(weatherManager.weatherModel?.daily.temperature_2m_min[day] ?? 0)")
                        
                                        Spacer().frame(width: 30)
                                        
                                        WeatherRow(logo: "", name: "Max Temp", value: "\(weatherManager.weatherModel?.daily.temperature_2m_max[day] ?? 0)")
                                    }
                                    .frame(maxWidth: .infinity)
                                    
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
                .frame(maxHeight: 620, alignment: .top)
                .padding()
                .background(Color(hue: 0.746, saturation: 0.488, brightness: 0.452).opacity(0.6).shadow(.inner(radius: 50)))
                .cornerRadius(35, corners: [.topLeft, .topRight])
            }
            
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(.linearGradient(colors: [.teal, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
        .preferredColorScheme(.dark)
    }
}

struct FavouriteCityView_Previews: PreviewProvider {
    @State static var favList = [CityName(name: "Stockholm", isFavorite: true), CityName(name: "Stockholm", isFavorite: true)]
    
    static var previews: some View {
        FavouriteCityView(weatherManager: WeatherManager(), selectCity: "Skara")
    }
}
