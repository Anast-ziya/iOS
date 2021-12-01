//
//  WaterManager.swift
//  WaterReminder
//
//  Created by Anastasia Burak on 15.11.21.
//

import Foundation

protocol WaterManagerDelegate: AnyObject {
    func waterHistoryChanged()
}

final class WaterManager {
    
    static let shared = WaterManager()
    private let store: AquaStore
    private(set) var currentWaterConsumption: DailyWaterConsumption
    weak var delegate: WaterManagerDelegate?
    
    private init() {
        let store = AquaStore.shared
        self.store = store
        
        currentWaterConsumption = store.waterConsumption ?? .init()
    }
    
    var todaysWaterCondsumption: Int {
        currentWaterConsumption.history.reduce(0) { restult, glasOfWater in
            if Calendar.current.isDateInToday(glasOfWater.date)  {
                return restult + glasOfWater.amount
            } else {
                return restult
            }
        }
    }
    
    var goalsProgress: Float? {
        get {
            let waterGoal = PreferencesManager.shared.waterConsumptionGoal
            let progress = Float(todaysWaterCondsumption) / Float(waterGoal)
            if progress > 1 {
                return 1
            } else  if progress < 0 {
                return 0
            } else {
                return progress
            }
        }
    }
    
    func add(glassOfWater: GlassOfWater) {
        currentWaterConsumption.history.append(glassOfWater)
        store.waterConsumption = currentWaterConsumption
        delegate?.waterHistoryChanged()
    }
}
