//
//  CurrentModel.swift
//  WeatherAPI
//
//  Created by Anastasia Burak on 3.10.21.
//

import Foundation

public struct CurrentWeather: Decodable {
    let lastUpdated: String
    let tempC: Double
    let tempF: Double
    
    enum CodingKeys: String, CodingKey {
        case lastUpdated = "last_updated"
        case tempC = "temp_c"
        case tempF = "temp_f"
    }
    
}
