//
//  UserPrefrences.swift
//  WaterReminder
//
//  Created by Anastasia Burak on 11.11.21.
//

import Foundation


struct UserPrefrences: Codable {
    var unit: Unit
    var weightInKg: Float
    var age: Int
    var activityLevel: ActivityLevel
}
