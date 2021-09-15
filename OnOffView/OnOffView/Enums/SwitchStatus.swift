//
//  SwitchStatus.swift
//  OnOffView
//
//  Created by Anastasia Burak on 1.09.21.
//

import Foundation

enum SwitchStatus: Togglable {
    
    case on, off
    
    mutating func toggle() {
        switch self {
       case .on:
            self = .off
       case .off:
            self = .on
        }
    }
}
