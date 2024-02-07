//
//  MenuView.swift
//  WeatherTask
//
//  Created by Muhammad Amiin Obidhonyi on 2022-11-10.
//

import SwiftUI

struct MenuView: View {
    private var menuContentArray = [
        "Today",
        "Daily",
        "Cities"
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(menuContentArray, id: \.self) {content in
                        Text("\(content)")
                            .font(.system(size: 50))
                            .cornerRadius(35)
                    }
                }
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MenuView()
        }
    }
}
