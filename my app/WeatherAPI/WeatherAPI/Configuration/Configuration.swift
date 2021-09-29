//
//  Configuration.swift
//  WeatherAPI
//
//  Created by Anastasia Burak on 29.09.21.
//

import Foundation

struct API {

    static let APIKey = "?key=ee0005d013eb42f895a130441211709"
    static let BaseURL =  "http://api.weatherapi.com/v1/current.json"
    
    static var AuthenticatedBaseURL: URL {
        let NewURL = URL(string: BaseURL + APIKey)!
        return NewURL
    }
}
