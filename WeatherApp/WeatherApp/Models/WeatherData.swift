//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Anastasia Burak on 24.09.21.
//

import Foundation

public struct WeatherData {

    public var city: String
    public var temperature: Double

    public init?(JSON: [String: AnyObject]) {
       
        if let location = JSON["location"], let current = JSON["current"] {
            guard let city = location["name"] as? String else { return nil }
            guard let temperature = current["temp_c"] as? Double else { return nil }
                    
            self.city = city
            self.temperature = temperature
        } else {
            return nil
        }
    }
}

