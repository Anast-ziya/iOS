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

    public init?(data: Data?) {
        if let data = data {
            do {
                let parsedResult: WeatherModel = try JSONDecoder().decode(WeatherModel.self, from: data)
                self.city = parsedResult.location.name
                self.temperature = parsedResult.current.tempC
            } catch let error {
                print(error)
            }
        }
    }
}
