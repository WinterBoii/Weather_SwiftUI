//
//  WeatherWeekView.swift
//  WeatherTask
//
//  Created by Muhammad Amiin Obidhonyi on 2022-11-09.
//

import SwiftUI
import Foundation

struct WeatherWeekView: View {
    @State var weather: ResponseBody
    @State private var formatter = Formatter()
    @StateObject var locationManager = LocationManager.shared
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                ScrollView {
                    
                    ForEach(weather.daily.time.indices, id: \.self) { day in
                        
                        HStack {
                            VStack {
                                ScrollView(.horizontal) {
                                    
                                    HStack {
                                        Text("\(formatter.convertDateFormat(inputDate: weather.daily.time[day]))")
                                            .font(.title)
                                            .fontWeight(.medium)
                                        Spacer()
                                            .frame(width: 15)
                                        WeatherRow(logo: "thermometer.high", name: "Max Temp", value: "\(weather.daily.temperature_2m_max[day])")
                                        Spacer()
                                        Image(systemName: formatter.weatherCode(code: weather.daily.weathercode[day]))
                                            .font(.system(size: 40))
                                    }
                                    .padding()
                                    
                                }
                            }
                            .padding(.horizontal)
                            .padding(.top)
                            .padding(.bottom)
                            
                        }
                        .frame(maxWidth: .infinity, minHeight: 100)
                        .background(Color(hue: 0.746, saturation: 0.488, brightness: 0.452).opacity(0.5))
                        .cornerRadius(30)
                        .padding(.horizontal)
                    }
                }
                .frame(maxWidth: 400, maxHeight: 700)
                .cornerRadius(50)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.bottom)
            .background(.linearGradient(colors: [.teal, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
            .preferredColorScheme(.dark)
            
            
        }
        .foregroundColor(.white)
        .navigationBarBackButtonHidden(false)
        .navigationTitle(Text("Daily Forecast"))
        .navigationBarTitleDisplayMode(.large)
    }
}

struct WeatherWeekView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            WeatherWeekView(weather: previewWeather)
        }
    }
}
