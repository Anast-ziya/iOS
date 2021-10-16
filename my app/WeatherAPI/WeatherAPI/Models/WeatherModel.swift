//
//  WeatherModel.swift
//  WeatherAPI
//
//  Created by Anastasia Burak on 3.10.21.
//

import Foundation

public struct WeatherModel: Decodable {

    public var location: Location
    public var current: Current
    
    enum CodingKeys: String, CodingKey {
        case location
        case current
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.location = try container.decode(Location.self, forKey: .location)
        self.current = try container.decode(Current.self, forKey: .current)

    }
}
