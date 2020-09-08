//
//  WeatherData.swift
//  Klima
//
//  Created by Rafael Plinio on 03/09/20.
//  Copyright © 2020 Rafael Plinio. All rights reserved.
//

import Foundation

//structs de acordo com o json da api openweathermap.org
struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let coord: CoordModel
    
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id: Int
    
}

struct CoordModel: Codable {
    
    let lat: Double
    let lon: Double
    
}
