//
//  WeatherData.swift
//  WeatherAPI
//
//  Created by Anastasia Burak on 29.09.21.
//

import Foundation

public struct WeatherData {
    
    public var city: String?
    public var temperature: Double?
    
    public init(city: String, temperature: Double) {
        self.city = city
        self.temperature = temperature
    }
    
}
