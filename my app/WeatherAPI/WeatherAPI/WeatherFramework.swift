//
//  WeatherFramework.swift
//  WeatherAPI
//
//  Created by Anastasia Burak on 29.09.21.
//

import Foundation

public typealias weatherRequest = (_ weatherData: WeatherData?, _ errorMessage: String?) -> ()

public class WeatherFramework {

    public class func getResponse(city: String, completion: @escaping weatherRequest) {
        let dataManager = DataManager(NewURL: API.AuthenticatedBaseURL)
        dataManager.weatherDataForCityName(city: city) { (response, error) in
            if let error = error {
                completion(nil, error.localizedDescription)
            } else {
                guard let JSON = response as? [String:AnyObject] else {
                    completion(nil, "Error")
                    return
                }
                if let weatherData = WeatherData(JSON: JSON) {
                    completion(weatherData, nil)
                } else {
                    completion(nil, "Error")
                }
            }
        }
    }
}
