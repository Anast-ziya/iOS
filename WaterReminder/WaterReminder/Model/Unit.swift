//
//  Unit.swift
//  WaterReminder
//
//  Created by Anastasia Burak on 11.11.21.
//

import Foundation

enum Unit: Int, CaseIterable, CustomStringConvertible, Codable {
    case metric
    case imperial
    
    static var count: Int {
        allCases.count
    }
    
    var description: String {
        switch self {
        case .metric: return "Metric"
        case .imperial: return "Imperial"
        }
    }
}
