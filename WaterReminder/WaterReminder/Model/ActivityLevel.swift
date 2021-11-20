//
//  ActivityLevel.swift
//  WaterReminder
//
//  Created by Anastasia Burak on 11.11.21.
//

import Foundation

enum ActivityLevel: Int, CaseIterable, CustomStringConvertible, Codable {
    case low
    case moderate
    case high
    case athelete
    
    static var count: Int {
        allCases.count
    }
    
    var description: String {
        switch self {
        case .low: return "Low"
        case .moderate: return "Moderate"
        case .high: return "High"
        case .athelete: return "Athelete"
        }
    }
}
