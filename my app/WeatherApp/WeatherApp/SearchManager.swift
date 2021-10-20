//
//  SearchManager.swift
//  WeatherApp
//
//  Created by Anastasia Burak on 18.10.21.
//

import Foundation
import UIKit
import WeatherAPI


final public class SearchManager {
    
    typealias SearchRequest = (_ weatherData: WeatherData?, _ errorMessage: String?) -> ()
    
    static func startSearch<T> (_ searchParam: Array<T>, completion: @escaping SearchRequest) {
        
        DataManager.getResponse(city: searchParam) { (weatherData, error) in
            if error != nil {
                completion(nil, error)
            } else {
                if let data = weatherData {
                    completion(data, nil)
                }
            }
        }
    }
}


