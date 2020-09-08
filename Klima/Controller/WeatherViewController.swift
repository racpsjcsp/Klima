//
//  ViewController.swift
//  Klima
//
//  Created by Rafael Plinio on 03/09/20.
//  Copyright © 2020 Rafael Plinio. All rights reserved.
//

import UIKit
import SwiftSoup
import CoreLocation

class WeatherViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    
    @IBOutlet weak var dia0: UILabel!
    @IBOutlet weak var min0: UILabel!
    @IBOutlet weak var max0: UILabel!
    
    @IBOutlet weak var dia1: UILabel!
    @IBOutlet weak var min1: UILabel!
    @IBOutlet weak var max1: UILabel!
    
    @IBOutlet weak var dia2: UILabel!
    @IBOutlet weak var min2: UILabel!
    @IBOutlet weak var max2: UILabel!
    
    @IBOutlet weak var dia3: UILabel!
    @IBOutlet weak var min3: UILabel!
    @IBOutlet weak var max3: UILabel!
    
    @IBOutlet weak var dia4: UILabel!
    @IBOutlet weak var min4: UILabel!
    @IBOutlet weak var max4: UILabel!
    
    @IBOutlet weak var dia5: UILabel!
    @IBOutlet weak var min5: UILabel!
    @IBOutlet weak var max5: UILabel!
    
    @IBOutlet weak var dia6: UILabel!
    @IBOutlet weak var min6: UILabel!
    @IBOutlet weak var max6: UILabel!
    
//    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    var weatherManager = WeatherManager()
    var lat: String = ""
    var lon: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //alertar a classe de que o usuário está digitando texto
//        searchTextField.delegate = self
        
        print("carregou didload")
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherManager.delegate = self
        searchTextField.delegate = self
        
        
        
        
        
//        raspagemHTML()
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        //esconde o teclado qdo usuário termina de digitar
        searchTextField.endEditing(true)
        
        print(searchTextField.text!)
    }
    
    @IBAction func favoritePressed(_ sender: UIButton) {
    
    }
   
    //detectar qdo clicar no "ir" (return) do teclado"
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
        
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Digite algo"
            return false
        }
    }
    
    //limpa o campo de busca
    func textFieldDidEndEditing(_ textField: UITextField) {
        //Use searchTextField.text to get weather for that city
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        
        searchTextField.text = "" //clear searchTextField after user finish the search
        
    }

        
    func raspagemHTML() {
            
            let darkskyURL = "https://darksky.net/forecast/\(lat),\(lon)/ca24/en"
                
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
                    
                        do {
                            let html = htmlString
                            
//                            let elementCity: Elements = try SwiftSoup.parse(html).select("title")
                            
                            
//                            print("pegando cidade...")
//                            print(elementCity[0])
                            let element: Element = try SwiftSoup.parse(html).getElementById("week")!
                            
                            let days: Elements = try element.getElementsByClass("day")
                            
                            var dataDay: [String] = []
                            var dataMin: [String] = []
                            var dataMax: [String] = []
                            for divs: Element in days {
//                                print(divs)
                                if let day: Element = try divs.getElementsByClass("name").first() {
                                    dataDay.append(try day.text())
                                    //print(try day.text())
                                }
                                if let minTemp: Element = try divs.getElementsByClass("minTemp").first() {
                                    dataMin.append(try minTemp.text())
                                    //print(try minTemp.text())
                                }
                                if let maxTemp: Element = try divs.getElementsByClass("maxTemp").first() {
                                    dataMax.append(try maxTemp.text())
                                    //print(try maxTemp.text())
                                }
                            }
                           
                            DispatchQueue.main.async {
                               for _ in dataDay {
                                   self.dia0.text = dataDay[0]
                                   self.min0.text = dataMin[0]
                                   self.max0.text = dataMax[0]

                                   self.dia1.text = dataDay[1]
                                   self.min1.text = dataMin[1]
                                   self.max1.text = dataMax[1]

                                   self.dia2.text = dataDay[2]
                                   self.min2.text = dataMin[2]
                                   self.max2.text = dataMax[2]

                                   self.dia3.text = dataDay[3]
                                   self.min3.text = dataMin[3]
                                   self.max3.text = dataMax[3]

                                   self.dia4.text = dataDay[4]
                                   self.min4.text = dataMin[4]
                                   self.max4.text = dataMax[4]

                                   self.dia5.text = dataDay[5]
                                   self.min5.text = dataMin[5]
                                   self.max5.text = dataMax[5]

                                   self.dia6.text = dataDay[6]
                                   self.min6.text = dataMin[6]
                                   self.max6.text = dataMax[6]
                               }
                            }
                            
                        } catch Exception.Error(type: let type, Message: let message) {
                            print(type)
                            print(message)
                        } catch {
                            print("")
                        }
                }
            
                task.resume()
                
            }    
}


extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last { //the .last should be the most accurate location  [CLLocation]
            print(location)
            locationManager.stopUpdatingLocation()
            lat = String(location.coordinate.latitude)
            lon = String(location.coordinate.longitude)
            
            //pega nome da cidade via coord
            let latDouble = Double(self.lat)
            let lonDouble = Double(self.lon)
            self.weatherManager.fetchCityName(lat: latDouble!, lon: lonDouble!)
            
            raspagemHTML()
            
        } else {
            print("nao pegou lat lon")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}


extension WeatherViewController: WeatherManagerDelegate {
    func requestLocation() {
        locationManager.requestLocation()
    }    
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
            self.lat = String(weather.lat)
            self.lon = String(weather.lon)
            
            self.raspagemHTML()
            print("print dispatch")
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
