//
//  DateFormatter.swift
//  WeatherTask
//
//  Created by Muhammad Amiin Obidhonyi on 2022-11-10.
//

import Foundation

class Formatter {
    //convertDateFormat() is from stackoverflow.com
    func convertDateFormat(inputDate: String) -> String {
        let olDateFormatter = DateFormatter()
        olDateFormatter.dateFormat = "yyyy-MM-d"
        
        let oldDate = olDateFormatter.date(from: inputDate)
        let convertDateFormatter = DateFormatter()
        convertDateFormatter.dateFormat = "EEE"
        
        return convertDateFormatter.string(from: oldDate!)
    }
    
    func convertDateFormatToHour(inputDate: String) -> String {
        let olDateFormatter = DateFormatter()
        olDateFormatter.dateFormat = "yyyy-MM-d'T'HH:mm"
        
        if let oldDate = olDateFormatter.date(from: inputDate) {
            let convertDateFormatter = DateFormatter()
            convertDateFormatter.dateFormat = "HH:mm"
            
            return convertDateFormatter.string(from: oldDate)
        } else {
            return "Invalid Date"
        }
    }
    

    
    func weatherCode(code: Int) -> String{
        switch code{
        case 1...3:
            return "cloud.sun"
        case 45...48:
            return "sun.haze"
        case 51...57:
            return "cloud.drizzle"
        case 61...67:
            return "cloud.rain"
        case 71...77:
            return "cloud.snow"
        case 80...82:
            return "cloud.rain"
        case 85...86:
            return "cloud.snow"
        case 95...99:
            return "cloud.bolt.rain"
        default:
            return "sun.max"
        }
    }
}
