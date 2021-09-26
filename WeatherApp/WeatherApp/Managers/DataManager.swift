//
//  DataManager.swift
//  WeatherApp
//
//  Created by Anastasia Burak on 23.09.21.
//

import Foundation

enum DataManagerError: Error {

    case Unknown
    case FailedRequest
    case InvalidResponse

}

final class DataManager {
    
    typealias WeatherDataCompletion = (AnyObject?, DataManagerError?) -> ()

    let NewURL: URL

    // MARK: - Initialization

    init(NewURL: URL) {
        self.NewURL = NewURL
    }
    
    // MARK: - Helper Methods

    private func didFetchWeatherData(data: Data?, response: URLResponse?, error: Error?, completion: WeatherDataCompletion) {
        if let _ = error {
            completion(nil, .FailedRequest)

        } else if let data = data, let response = response as? HTTPURLResponse {
            if response.statusCode == 200 {
                processWeatherData(data: data, completion: completion)
            } else {
                completion(nil, .FailedRequest)
            }

        } else {
            completion(nil, .Unknown)
        }
    }
    
    private func processWeatherData(data: Data, completion: WeatherDataCompletion) {
        if let JSON = try? JSONSerialization.jsonObject(with: data, options: []) as AnyObject {
            completion(JSON, nil)
        } else {
            completion(nil, .InvalidResponse)
        }
    }

    // MARK: - Requesting Data
    
    func weatherDataForCityName(city: String, completion: @escaping WeatherDataCompletion) {
        // Create URL
        let URL = URL(string: NewURL.absoluteString + "&q=\(city)&aqi=no")!
        
        // Create Data Task
        URLSession.shared.dataTask(with: URL) { (data, response, error) in
                self.didFetchWeatherData(data: data, response: response, error: error, completion: completion)
               }.resume()
        
       }
    
}
