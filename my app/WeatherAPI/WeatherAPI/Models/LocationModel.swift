//
//  LocationModel.swift
//  WeatherAPI
//
//  Created by Anastasia Burak on 3.10.21.
//

import Foundation

public struct Location: Decodable {
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double
    let tzId: String
    let localtime : String
    
    enum CodingKeys: String, CodingKey {
        case name
        case region
        case country
        case lat
        case lon
        case tzId = "tz_id"
        case localtime
    }
    
}
