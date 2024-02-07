//
//  FavouriteListView.swift
//  WeatherTask
//
//  Created by Muhammad Amiin Obidhonyi on 2022-11-30.
//

import SwiftUI

struct FavouriteListView: View {
    @StateObject var weatherManager = WeatherManager()
    @Binding  var favList : [CityName]
    
    var body: some View {
        Text("Favourite Cities")
        
        NavigationStack{
            if favList.isEmpty {
                Text("There is no Cities in Favorits")
            } else {
                List {
               
                    ForEach(favList, id: \.self) { item in
                        HStack{
                            
                            NavigationLink("\(item.name)") { FavouriteCityView(weatherManager: weatherManager, selectCity: item.name) }
                                .task {
                                    let _ = weatherManager.getLatLonFromCity(cityName: item.name)
                                }
                        }
                    }
                    .onDelete(perform: { indexSet in
                        favList.remove(atOffsets: indexSet )
                    })
                }
                
            }

        }
    }
}

struct FavouriteListView_Previews: PreviewProvider {
    @State static var favList = [CityName(name: "Stockholm", isFavorite: true), CityName(name: "Stockholm", isFavorite: true)]

    static var previews: some View {
        FavouriteListView(favList: $favList)
    }
}
