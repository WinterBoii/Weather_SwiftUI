//
//  FavACity.swift
//  WeatherTask
//
//  Created by Muhammad Amiin Obidhonyi on 2022-12-01.
//  help from mofleh

import SwiftUI

struct FavACity: View {
    @StateObject var weatherManager = WeatherManager()
    @Binding var favList: [CityName]
    var selectCity: String
    @State var isShown = false
    
    var body: some View {
        
        if weatherManager.didFind == false {
            Text("City not found")
        } else {
  
            Text("\(selectCity)")
                .font(.title)
            
            Button("Add To Favorite") {
                let newCity = CityName(name: selectCity, isFavorite: true)
                isShown = doesExist(inputCity: newCity.name, listToSearch: favList)
                
                if(isShown==false){
                    favList.append(newCity)
                }
  
            }
            .alert(isPresented: $isShown) {
                Alert(title: Text("This city already exists"))
            }
            
            HStack{
                Text("Day")
                    .bold().frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                Spacer()
                Text("Minimum")
                    .bold().frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                Spacer()
                Text("Maximum")
                    .bold().frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                
            }
    
            ForEach(0..<7){ i in
                HStack {
                    
                    Text(
                        "\(Date().addingTimeInterval(TimeInterval(60*60*24*i)).formatted(.dateTime.weekday()) )")
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    
                    Spacer()
                    
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                    Text("\(weatherManager.weatherModel?.daily.temperature_2m_min[i] ?? 0)" + "°" )
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    
                    Spacer()
                    
                    Text("\(weatherManager.weatherModel?.daily.temperature_2m_max[i] ?? 0)" + "°" )
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                }
                
            }
        }
    }
    
    func doesExist(inputCity: String,  listToSearch: [CityName]) -> Bool {
        
        for task in listToSearch {
            if inputCity == task.name {
                return true
            }
        }
        return false
    }
}

struct FavACity_Previews: PreviewProvider {
    @State static var favList = [CityName(name: "Stockholm", isFavorite: true),CityName(name: "Stockholm", isFavorite: true)]
    
    static var previews: some View {
        FavACity(favList: $favList, selectCity: "Nybro")
    }
}
