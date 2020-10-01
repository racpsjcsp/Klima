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
import CLTypingLabel

class WeatherViewController: UIViewController, UITextFieldDelegate  {
    
    @IBOutlet weak var viewForSwipe: UIView!
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: CLTypingLabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var favoriteButton: UIButton!
    
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
    
    let locationManager = CLLocationManager()
    var weatherManager = WeatherManager()
    var lat: String = ""
    var lon: String = ""
    var city: String = ""
    var temp: String = ""
    var cidades: [String] = []
    var temperatura: [String] = []
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //atualizando info via GPS
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherManager.delegate = self
        searchTextField.delegate = self
        
        if let cidadesDefaults = defaults.array(forKey: "ListaFavoritos") as? [String] {
            cidades = cidadesDefaults
        }
        
        print(defaults.array(forKey: "ListaFavoritos") ?? [])
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true) //esconde o teclado qdo usuário termina de digitar
    }
    
    @IBAction func favoritePressed(_ sender: UIButton) { //pegar cidade da label e passar para segue
        city = cityLabel.text!

        if let cidadesDefaults = defaults.array(forKey: "ListaFavoritos") as? [String] {
            cidades = cidadesDefaults
        }
        
        if !cidades.contains(city) {
            cidades.append(city)
            defaults.set(cidades, forKey: "ListaFavoritos")
        }
    }
        
    //verifica se o alerta vai aparecer, se sim, evita de ir para a próxima segue (favoritos)
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if let ident = identifier {
            if ident == "addFavoriteView" {
                if city == "" {
                    return false //return false para cancelar a passagem de tela
                }
                if self.cidades.contains(city) {
//                    let cancelAlert = UIAlertAction(title: "OK", style: .cancel)
//                    let alert = UIAlertController(title: "Aviso", message: "Cidade já adicionada!", preferredStyle: .alert)
//                    present(alert, animated: true)
//                    alert.addAction(cancelAlert)
                    
                    return true
                }
            }
        }
        return true
    }
    
    //envia os dados para a segue (favoritos)
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "addFavoriteView" {
//            let vc = segue.destination as! FavoriteTableViewController
//
//            if self.cidades.contains("") {
//                self.cidades.remove(at: 0)
//            }
//            if !self.cidades.contains(city) {
//                self.cidades.append(city)
//                vc.cidades.append(city)

//                print("dentro do prepare()")
//                 print("print cidade: \(cidades)")
//                print(defaults.array(forKey: "ListaFavoritos") ?? [])
//                self.temperatura.append(temp)
//            }
//            vc.cidades = self.cidade
//
//        }
//
//        //guardando data ao clicar para visualizar os favoritos
//        if segue.identifier == "viewFavorites" {
//            let vc = segue.destination as! FavoriteTableViewController
//            vc.cidades = self.cidades
//        }
//    }
    
    //detectar qdo clicar no "ir" (return) do teclado"
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
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
        //Usa searchTextField.text pra pegar o clima da cidade
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        searchTextField.text = "" //limpa o searchTextField depois de realizar a busca
    }
    
    func raspagemDarkSky() {
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
                let element: Element = try SwiftSoup.parse(html).getElementById("week")!
                let days: Elements = try element.getElementsByClass("day")
                var dataDay: [String] = []
                var dataMin: [String] = []
                var dataMax: [String] = []
                for divs: Element in days {
                    if let day: Element = try divs.getElementsByClass("name").first() {
                        
                        //traduzindo EN -> PT
                        if try day.text() == "Today" {
                            dataDay.append("Hoje")
                        } else if try day.text() == "Mon" {
                            dataDay.append("Seg")
                        } else if try day.text() == "Tue" {
                            dataDay.append("Ter")
                        } else if try day.text() == "Wed" {
                            dataDay.append("Qua")
                        } else if try day.text() == "Thu" {
                            dataDay.append("Qui")
                        } else if try day.text() == "Fri" {
                            dataDay.append("Sex")
                        } else if try day.text() == "Sat" {
                            dataDay.append("Sáb")
                        } else if try day.text() == "Sun" {
                            dataDay.append("Dom")
                        }
                    }
                    if let minTemp: Element = try divs.getElementsByClass("minTemp").first() {
                        dataMin.append(try "\(minTemp.text())min")
                    }
                    if let maxTemp: Element = try divs.getElementsByClass("maxTemp").first() {
                        dataMax.append(try "\(maxTemp.text())max")
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
        if let location = locations.last { //o  .last deve retornar a localização mais precisa [CLLocation]
            print(location)
            locationManager.stopUpdatingLocation()
            lat = String(location.coordinate.latitude)
            lon = String(location.coordinate.longitude)
            
            //pega nome da cidade via coord
            let latDouble = Double(self.lat)
            let lonDouble = Double(self.lon)
            self.weatherManager.fetchCityName(lat: latDouble!, lon: lonDouble!)
            
            raspagemDarkSky()
            
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
            self.conditionImageView.isHidden = false
            self.temperatureLabel.text = "\(weather.temperatureString)°C"
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
            //print(self.cityLabel.text!)
            self.lat = String(weather.lat)
            self.lon = String(weather.lon)
            self.raspagemDarkSky()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}


