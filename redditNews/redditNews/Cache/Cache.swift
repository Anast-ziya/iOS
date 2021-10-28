//
//  Cache.swift
//  redditNews
//
//  Created by Anastasia Burak on 27.10.21.
//

import Foundation

class Cache<Key, Value> where Key : Hashable {
    
    private var queue = DispatchQueue(label: "asta.CacheSerialQueue")
    
    private var cachedItems: [Key: Value] = [:]
    
    subscript(_ key: Key) -> Value? {
        get {
            return queue.sync { cachedItems[key] ?? nil }
        }
    }
    
    func cache(value: Value, for key: Key) {
        queue.async { self.cachedItems[key] = value }
    }
}
