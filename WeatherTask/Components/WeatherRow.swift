//
//  WeatherRow.swift
//  WeatherTask
//
//  Created by Muhammad Amiin Obidhonyi on 2022-11-03.
//

import SwiftUI

struct WeatherRow: View {
    var logo: String
    var name: String
    var value: String
    
    var body: some View {
        VStack(spacing: 5) {
            Image(systemName: logo)
                .font(.title)
            
            VStack(alignment: .center, spacing: 5) {
                Text(name)
                    .font(.caption)
                
                Text(value)
                    .bold()
                    .font(.title2)
            }
        }
    }
}

struct WeatherRow_Previews: PreviewProvider {
    static var previews: some View {
        WeatherRow(logo: "thermometer", name: "Feels like", value: "8°")
    }
}
