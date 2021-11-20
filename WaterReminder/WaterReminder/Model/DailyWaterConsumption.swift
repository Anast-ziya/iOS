//
//  GlassOfWater.swift
//  WaterReminder
//
//  Created by Anastasia Burak on 11.11.21.
//

import Foundation

struct DailyWaterConsumption: Codable {
    var history: [GlassOfWater] = []
    var goal: Int = 2550
}

struct GlassOfWater: Codable {
    let amount: Int
    var date: Date = Date()
}
