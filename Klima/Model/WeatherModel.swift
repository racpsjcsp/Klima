//
//  WeatherModel.swift
//  Klima
//
//  Created by Rafael Plinio on 03/09/20.
//  Copyright © 2020 Rafael Plinio. All rights reserved.
//

import Foundation

//dados para pegar do JSON (openweather)
struct WeatherModel {
    let conditionID: Int
    let cityName: String
    let temperature: Double
    
    let lat: Double
    let lon: Double
    
    //computed property
    //retorna o icone de acordo com o clima
    var conditionName: String {
        switch conditionID {
            case 200...232:
                return "cloud.bolt"
            case 300...321:
                return "cloud.drizzle"
            case 500...531:
                return "cloud.rain"
            case 600...622:
                return "cloud.snow."
            case 700...781:
                return "cloud.fog"
            case 800:
                return "sun.max"
            case 801...804:
                return "cloud.bolt"
            default:
                return "cloud"
        }
    }
    
    var temperatureString: String {
        return String(format: "%.1f",temperature)
    }
}









