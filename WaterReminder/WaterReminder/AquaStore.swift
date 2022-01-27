//
//  AquaStore.swift
//  WaterReminder
//
//  Created by Anastasia Burak on 11.11.21.
//

import Foundation

final class AquaStore {
    
    static let shared = AquaStore()
    
    private let store: UserDefaults
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private enum Key: String {
        case waterConsumption
        case preferences
    }
    
    private init(store: UserDefaults = UserDefaults(suiteName: "AquaStore")!) {
        self.store = store
    }
    
    var waterConsumption: DailyWaterConsumption? {
        get { retrieve(for: .waterConsumption) }
        set { store(newValue, for: .waterConsumption) }
    }
    
    var preferences: UserPrefrences? {
        get { retrieve(for: .preferences) }
        set { store(newValue, for: .preferences) }
    }
    
    // MARK: - Helper
    
    private func store<T: Encodable>(_ object: T?, for key: Key) {
        let key = wrap(key)
        guard let object = object else {
            store.removeObject(forKey: key)
            return
        }
        guard let encodedObject = try? encoder.encode(object) else {
            print("Can't encode object with type: '\(object.self)'")
            return
        }
        store.set(encodedObject, forKey: key)
    }
    
    private func retrieve<T: Decodable>(for key: Key) -> T? {
        guard let savedObject = store.data(forKey: wrap(key)),
              let object = try? decoder.decode(T.self, from: savedObject) else {
                  return nil
              }
        return object
    }
    
    private func wrap(_ key: Key) -> String {
        let rawKey = key.rawValue
#if DEBUG
        return rawKey + "_debug"
#else
        return rawKey
#endif
    }
}
