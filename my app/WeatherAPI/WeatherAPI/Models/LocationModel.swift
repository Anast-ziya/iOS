//
//  LocationModel.swift
//  WeatherAPI
//
//  Created by Anastasia Burak on 3.10.21.
//

import Foundation

public struct Location: Decodable {
    var name: String
    var region: String
    var country: String
    var lat: Double
    var lon: Double
    var tzId: String
    var localtime : String
    
    enum CodingKeys: String, CodingKey {
        case name
        case region
        case country
        case lat
        case lon
        case tzId = "tz_id"
        case localtime
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try container.decode(String.self, forKey: .name)
        self.region = try container.decode(String.self, forKey: .region)
        self.country = try container.decode(String.self, forKey: .country)
        self.lat = try container.decode(Double.self, forKey: .lat)
        self.lon = try container.decode(Double.self, forKey: .lon)
        self.tzId = try container.decode(String.self, forKey: .tzId)
        self.localtime = try container.decode(String.self, forKey: .localtime)
    }
}
