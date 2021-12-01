//
//  PreferencesManager.swift
//  WaterReminder
//
//  Created by Anastasia Burak on 11.11.21.
//

import Foundation
import UIKit

protocol PreferenceDelegate: AnyObject {
    func userPreferencesChanged()
}

final class PreferencesManager {
    
    static let shared = PreferencesManager()
    private let store: AquaStore
    weak var delegate: PreferenceDelegate?
    var currentUserPrefrences: UserPrefrences? {
        get {
            store.preferences
        }
        set {
            store.preferences = newValue
        }
    }
    
    init() {
        let store = AquaStore.shared
        self.store = store
    }
    
    func updateUserPreferences() {
        delegate?.userPreferencesChanged()
    }
    
    
    static func poundsToKgConverter(pounds: Float) -> Float {
        let kg = Float(pounds) / 2.20462
        return kg
    }
    
    
    static func kgToPoundsConverter(kg: Float) -> Int {
        var pounds = Float(kg) * 2.20462
        pounds.round(.toNearestOrAwayFromZero)
        return Int(pounds)
    }
    
    var waterConsumptionGoal: Int {
        guard let currentWeightKg = currentUserPrefrences?.weightInKg else {
            return 0
        }
        var waterGoal = Int(currentWeightKg) * 30
        
        guard let activityLevel = currentUserPrefrences?.activityLevel else {
            return waterGoal
        }
        switch activityLevel {
        case .moderate: waterGoal += 300
        case .high: waterGoal += 600
        case .athelete: waterGoal += 900
        case .low: break
        }
        
        return waterGoal
    }
    
    func waterUnitConverter(waterAmount: Int, currentUnit: Unit) -> Int {
        if currentUnit == .metric {
            return waterAmount
        } else {
            return Int(Float(waterAmount) * 29.573)
        }
    }
    
    func updateWeight() {
        guard let currentUserPrefrences = currentUserPrefrences else {
            return
        }
        self.currentUserPrefrences = currentUserPrefrences
    }
    
    var unitDisplayed: String {
        guard let currentUserPrefrences = currentUserPrefrences else {
            return "Add water to see progress here"
        }
        
        let unit = currentUserPrefrences.unit
        
        if unit == .metric {
            return "\(waterConsumptionGoal)"
        } else {
            let milliliterToOunce = Int(Float(waterConsumptionGoal) * 0.0338)
            return "\(milliliterToOunce)"
        }
    }
    
    //MARK: - Data source
    
    var unitDataSource: [Unit] {
        return Unit.allCases
    }
    
    let weightKgDataSource: [Int] = {
        var weight: [Int] = []
        for i in 20...400 {
            weight.append(i)
        }
        return weight
    }()
    
    let weightIbsDataSource: [Int] = {
        var weight: [Int] = []
        for i in 44...882 {
            weight.append(i)
        }
        return weight
    }()
    
    let ageDataSource: [Int] = {
        var age: [Int] = []
        for i in 10...100 {
            age.append(i)
        }
        return age
    }()
    
    var activtiyLevelDataSource: [ActivityLevel] {
        return ActivityLevel.allCases
    }
}
