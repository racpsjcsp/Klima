//
//  WeatherManager.swift
//  Klima
//
//  Created by Rafael Plinio on 03/09/20.
//  Copyright © 2020 Rafael Plinio. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
    func requestLocation()
}

struct WeatherManager {
    let darkSkyURL = "https://darksky.net/forecast/"
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=2f55e435cb439c9c7107c8bd54261c91&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)        
    }
    
    func fetchCityName(lat: Double, lon: Double) {
        let urlString = "\(weatherURL)&lat=\(lat)&lon=\(lon)"
        performRequest(with: urlString)
    }
    
//    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> [String] {
//        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
//        let urlDarkSkyString = "\(darkSkyURL)\(latitude),\(longitude)/ca24/en"
//        //performRequest(with: urlString)
//        return [latitude, longitude]
//    }
    
    func performRequest(with urlString: String) {
        
        //1 - cria a URL
        if let url = URL(string: urlString) {
            
            //2  - cria a URLSession
            let session = URLSession(configuration: .default)
            
            //3 - atribui uma tarefa para a session
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(weatherData: safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    } //dentro de uma closure, precisa de self.
                }
            }
            
            //4 - inicia a tarefa
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        //do try catch block
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let lat = decodedData.coord.lat
            let lon = decodedData.coord.lon
            

            let weather = WeatherModel(conditionID: id, cityName: name, temperature: temp, lat: lat, lon: lon)
            return weather
            
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    func performRaspagem(with urlString: String) {
        let darkskyURL = "https://darksky.net/forecast/"
        //-23.196,-45.887/ca24/en"
        
        let url = URL(string: darkskyURL)
        
        let task = URLSession.shared.dataTask(with: url!) { (data, resp, error) in
            guard let data = data else {
                print("data was nil")
                return
            }
        
            guard let htmlString = String(data: data, encoding: String.Encoding.utf8) else {
                print("Cant cast data into string")
                return
            }
        
            print(htmlString)
        }
        
        task.resume()
    }
}
