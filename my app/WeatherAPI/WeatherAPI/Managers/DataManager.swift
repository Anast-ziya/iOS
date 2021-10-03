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

final class DataManager {
    
    typealias WeatherDataCompletion = (Data?, DataManagerError?) -> ()

    // MARK: - Helper Methods

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
