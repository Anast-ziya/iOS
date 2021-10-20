//
//  DataManager.swift
//  WeatherAPI
//
//  Created by Anastasia Burak on 29.09.21.
//

import Foundation

enum DataManagerError: Error {
    case unknown
    case failedRequest
    case invalidResponse
}

final public class DataManager {
    
    typealias WeatherDataCompletion = (Data?, DataManagerError?) -> ()
    public typealias WeatherRequest = (_ weatherData: WeatherData?, _ errorMessage: String?) -> ()
    
    // MARK: - Helper Methods
    
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
                do {
                    let parsedResult: WeatherModel = try JSONDecoder().decode(WeatherModel.self, from: data)
                    let weatherData = WeatherData(city: parsedResult.location.name, temperature: parsedResult.currentWeather.tempC)
                    completion(weatherData, nil)
                } catch let error {
                    print(error)
                }
            }
        }
    }
    
    private func didFetchWeatherData(data: Data?, response: URLResponse?, error: Error?, completion: WeatherDataCompletion) {
        if let _ = error {
            completion(nil, .failedRequest)
        } else if let data = data, let response = response as? HTTPURLResponse {
            if response.statusCode == 200 {
                completion(data, nil)
            } else {
                completion(nil, .failedRequest)
            }
        } else {
            completion(nil, .unknown)
        }
    }
    
    // MARK: - Requesting Data
    
    func weatherDataForCity<T>(city: Array<T>, completion: @escaping WeatherDataCompletion) {
        // Create URL
        let stringLocation = city.map{"\($0)"}.joined(separator: ",")
        let url = URL(string: "http://api.weatherapi.com/v1/current.json?")
        let queryItems = [URLQueryItem(name: "key", value: "ee0005d013eb42f895a130441211709"),
                          URLQueryItem(name: "q", value: "\(stringLocation)"),
                          URLQueryItem(name: "aqi", value: "no")]
        let newUrl = url?.appending(queryItems)
        
        if let URL = newUrl {
            URLSession.shared.dataTask(with: URL) { (data, response, error) in
                self.didFetchWeatherData(data: data, response: response, error: error, completion: completion)
            }.resume()
        }
    }
}

extension URL {
    func appending(_ queryItems: [URLQueryItem]) -> URL? {
        guard var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true) else { return nil }
        urlComponents.queryItems = (urlComponents.queryItems ?? []) + queryItems
        return urlComponents.url
    }
}
