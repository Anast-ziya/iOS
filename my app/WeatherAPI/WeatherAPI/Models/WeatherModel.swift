//
//  WeatherModel.swift
//  WeatherAPI
//
//  Created by Anastasia Burak on 3.10.21.
//

import Foundation

public struct WeatherModel: Decodable {
    
    public let location: Location
    public let currentWeather: CurrentWeather
    
    enum CodingKeys: String, CodingKey {
        case location
        case currentWeather = "current"
    }
    
}
