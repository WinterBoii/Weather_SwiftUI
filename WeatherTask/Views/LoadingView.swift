//
//  LoadingView.swift
//  WeatherTask
//
//  Created by Muhammad Amiin Obidhonyi on 2022-11-02.
//  Video used https://youtu.be/X2W9MPjrIbk



import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .white))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
