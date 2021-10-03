//
//  WeatherFramework.swift
//  WeatherAPI
//
//  Created by Anastasia Burak on 29.09.21.
//

import Foundation

public typealias WeatherRequest = (_ weatherData: WeatherData?, _ errorMessage: String?) -> ()

public class WeatherFramework {

    public class func getResponse<T>(city: Array<T>, completion: @escaping WeatherRequest) {
        let dataManager = DataManager()
        dataManager.weatherDataForCity(city: city) { (response, error) in
            if let error = error {
                completion(nil, error.localizedDescription)
            } else {
                guard let data = response else {
                    completion(nil, "Error")
                    return
                }
                if let weatherData = WeatherData(data: data) {
                    completion(weatherData, nil)
                } else {
                    completion(nil, "Error")
                }
            }
        }
    }
}
