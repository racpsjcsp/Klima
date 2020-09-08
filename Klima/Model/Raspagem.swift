//
//  Raspagem.swift
//  Klima
//
//  Created by Rafael Plinio on 05/09/20.
//  Copyright © 2020 Rafael Plinio. All rights reserved.
//

import Foundation
import CoreLocation

struct Raspagem {
    
    func performRequest(with urlString: String) {
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


