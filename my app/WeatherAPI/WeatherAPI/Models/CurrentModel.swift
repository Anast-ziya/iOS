//
//  CurrentModel.swift
//  WeatherAPI
//
//  Created by Anastasia Burak on 3.10.21.
//

import Foundation

public struct Current: Decodable {
    var lastUpdated: String
    var tempC: Double
    var tempF: Double
    
    enum CodingKeys: String, CodingKey {
        case lastUpdated = "last_updated"
        case tempC = "temp_c"
        case tempF = "temp_f"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.lastUpdated = try container.decode(String.self, forKey: .lastUpdated)
        self.tempC = try container.decode(Double.self, forKey: .tempC)
        self.tempF = try container.decode(Double.self, forKey: .tempF)
    }
}
