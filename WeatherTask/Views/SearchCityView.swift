//
//  SearchCityView.swift
//  WeatherTask
//
//  Created by Muhammad Amiin Obidhonyi on 2022-11-30.
//

import SwiftUI

struct CityName: Hashable {
    var name : String
    var isFavorite : Bool
    
    init(name: String, isFavorite: Bool) {
        self.name = name
        self.isFavorite = isFavorite
        
    }
}

struct SearchCityView: View {
    @StateObject var weatherManager = WeatherManager.shared
    @State private var searchCity = ""
    @State private var favList : [CityName] = []
    @State  var showCity : Bool = false
    @State  var showFavList : Bool = false

    var body: some View {
        
        HStack {
            Button("Favourite View") {
                showFavList.toggle()
            }.sheet(isPresented: $showFavList, content: {
                FavouriteListView(favList: $favList)
                    .padding()
            })
            
        }
        Spacer()
        
        List() {
            Section{
                TextField("Choose city", text: $searchCity)
                    .onSubmit {
                        weatherManager.getLatLonFromCity(cityName: searchCity)
                        showCity = true}
                
                    .sheet(isPresented: $showCity, content: {
                        
                        FavACity(weatherManager: weatherManager, favList: $favList, selectCity: searchCity)
                            .padding()
                        
                    })
            }
            
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(.linearGradient(colors: [.teal, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
        .preferredColorScheme(.dark)
    }
}

struct SearchCityView_Previews: PreviewProvider {
    static var previews: some View {
        SearchCityView()
    }
}
